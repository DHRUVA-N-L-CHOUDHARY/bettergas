import 'package:bettergas_assignment/app/data/models/Product_info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';

class ProductController extends GetxController {
  RxInt selectedProduct = 0.obs;
  RxString selectedValue = "0".obs;
  RxInt selectedQuantity = 1.obs;
  RxString amount = "280".obs;
  double amountValue = 0.0;
  DateTime? pickedDate = DateTime.now();
  String orderid = "0";
  String termid = Get.arguments["term_id"];
  String orderkey = "wc_order";
  RxBool isLoading = false.obs;
  String name = Get.arguments["name"];
  String address = Get.arguments["address"];
  List<ProductInfoModel> productsinfo = List.empty(growable: true);
  Set<String> uniqueSet = new Set();
  List<String> uniqueList = new List.empty(growable: true);
  RxBool isIncrementButtonClicked = false.obs;
  RxBool isDecrementButtonClicked = false.obs;
  NumberFormat formatter = NumberFormat('#,##0.00');

  @override
  void onInit() async {
    name = Get.arguments["name"];
    address = Get.arguments["address"];
    productsinfo = Get.arguments["product"];
    print(productsinfo[0].weight);
    debounce(
        isIncrementButtonClicked, (_) => isIncrementButtonClicked.value = false,
        time: Duration(milliseconds: 30));
    debounce(
        isDecrementButtonClicked, (_) => isDecrementButtonClicked.value = false,
        time: Duration(milliseconds: 30));
    amount.value = (selectedProduct.value == 0
        ? "₦${productsinfo.length != 0 ? double.parse(productsinfo[1].displayPrice.toString()) : 280.00 * selectedQuantity.value}"
        : "₦${productsinfo.length != 0 ? double.parse(productsinfo[0].displayPrice.toString()) : 380.00 * selectedQuantity.value}");
    amountValue = (selectedProduct.value == 0
        ? productsinfo.length != 0
            ? double.parse(productsinfo[1].displayPrice.toString())
            : 280.00 * selectedQuantity.value
        : productsinfo.length != 0
            ? double.parse(productsinfo[0].displayPrice.toString())
            : 380.00 * selectedQuantity.value);
    print(amountValue);

    amount.value = "₦${formatter.format(amountValue)}";
    print(amount.value);
    selectedValue.value = productsinfo[0].weight.toString();
    await findUniqueValues();
    update();
    super.onInit();
  }

  decrement() {
    if (!isDecrementButtonClicked.value) {
      isDecrementButtonClicked.value = true;
      if (selectedQuantity.value > 1) {
        selectedQuantity.value--;
        update();
      } else {
        Get.snackbar("Error", "Minimum quantity of 1 is required.",
            backgroundColor: kSecondaryBlue,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  increment() {
    if (!isIncrementButtonClicked.value) {
      isIncrementButtonClicked.value = true;
      if (selectedQuantity.value < 3) {
        selectedQuantity.value++;
        update();
      } else {
        Get.snackbar("Error", "Maximum quantity cannot be greater than 3",
            backgroundColor: kSecondaryBlue,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  findUniqueValues() {
    productsinfo.forEach((element) {
      if (!uniqueSet.contains(element.weight)) {
        uniqueList.add(element.weight.toString());
      }
      uniqueSet.add(element.weight.toString());
    });
    update();
  }

  Future<bool> createOrder(
      String amount, int quantity, String variationid) async {
    try {
      isLoading(true);
      update();
      Map<String, dynamic> data = {
        "customer_id": MySharedPref.getUserId(),
        "payment_method": "paystack",
        "payment_method_title": "Paystack",
        "currency": "NGN",
        "prices_include_tax": false,
        "discount_total": "0",
        "discount_tax": "0",
        "shipping_total": "0",
        "shipping_tax": "0",
        "cart_tax": "0",
        "total": "$amount",
        "total_tax": "0",
        "set_paid": false,
        "billing": {
          "first_name": MySharedPref.getName(),
          "last_name": "",
          "company": "",
          "address_1": "",
          "address_2": "",
          "city": "",
          "state": "",
          "postcode": "",
          "country": "NG",
          "email": MySharedPref.getEmail(),
          "phone": MySharedPref.getPhone()
        },
        "created_via": "app",
        "new_order_email_sent": true,
        "recorded_sales": true,
        "recorded_coupon_usage_counts": true,
        "line_items": [
          {
            "product_id": 54,
            "variation_id": variationid,
            "quantity": quantity.toString(),
            "meta_data": [
              {
                "key": "woocommerce_multi_inventory_inventory_$variationid",
                "value": termid
              }
            ]
          }
        ]
      };
      print(data);
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      Map result = await ApiService().createOrder(data);
      if (result["id"] != null) {
        orderid = result["id"].toString();
        orderkey = result["order_key"].toString();
        update();
        isLoading(false);
        update();
        return true;
      } else {
        Get.snackbar("Error", "Failed to Create Order. Please contact admin",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
        return false;
      }
    } on Exception catch (e) {
      isLoading(false);
      update();
      throw e;
    }
  }

  void getCurrentDate(BuildContext context) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    update();
  }
}
