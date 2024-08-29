import 'package:bettergas_assignment/app/data/local/my_shared_pref.dart';
import 'package:bettergas_assignment/app/data/models/paystack_auth_model.dart';
import 'package:bettergas_assignment/app/data/models/transaction_customer_model.dart';
import 'package:bettergas_assignment/app/data/remote/paystack/paystack_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/common_utils.dart';
import '../../../components/snackBar.dart';
import '../../../data/remote/api_service.dart';
import '../../../routes/app_pages.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;
  String email = MySharedPref.getEmail();
  String amount = "100.0";
  String currency = "GHS";
  String reference = "";
  RxBool hasData = true.obs;
  RxBool statusofTrasaction = false.obs;
  List<String> channels = ["card", "mobile_money"];
  String orderid = Get.arguments["orderid"];
  String orderkey = Get.arguments["orderkey"];
  Object? metadata;
  RxBool iswebViewLoading = false.obs;
  late WebViewController paymentwebviewController;
  late Function(Object?) onCompletedTransaction;
  late Function(Object?) onFailedTransaction;
  late PayStackAuthModel intializedPayment = PayStackAuthModel();
  RxString refrenceUrl = "".obs;

  @override
  void onInit() async {
    isLoading(true);
    amount = Get.arguments["amount"].toString().split(".").join();
    orderid = Get.arguments["orderid"];
    refrenceUrl =
        await "https://bettergas.com/new/checkout/order-pay/$orderid/?key=$orderkey&mode_view=app"
            .obs;
    print(
        "--------------------------------------++++++++++++++++++++++++++++++++++++");
    print(orderid);
    reference = "${orderid}_${DateFormat("DDMMHHmmss").format(DateTime.now())}";
    onCompletedTransaction = (data) {
      debugPrint("Completed Transaction:: ${data.toString()}");
    };
    onFailedTransaction = (data) {
      debugPrint("Failed Transaction:: ${data.toString()}");
    };
    intializedPayment = await intializePayment();
    update();
    isLoading(false);
    super.onInit();
  }

  Future<PayStackAuthModel> intializePayment() async {
    try {
      iswebViewLoading(true);
      update();
      Map<String, dynamic> data = {
        "email": email,
        "amount": amount,
        "currency": "NGN",
        "channels": channels,
        "reference": reference,
        "referrer": refrenceUrl.value,
        "callback_url": refrenceUrl.value,
        "mode": "popup",
        "metadata": {
          "custom_fields": [
            {
              "display_name": "Order ID",
              "variable_name": "order_id",
              "value": orderid
            },
            {
              "display_name": "User ID",
              "variable_name": "user_id",
              "value": MySharedPref.getUserId()
            },
            {
              "display_name": "Customer Name",
              "variable_name": "customer_name",
              "value": MySharedPref.getName()
            },
            {
              "display_name": "Customer Email",
              "variable_name": "customer_email",
              "value": MySharedPref.getEmail()
            },
            {
              "display_name": "Customer Phone",
              "variable_name": "customer_phone",
              "value": MySharedPref.getPhone()
            },
            {
              "display_name": "Products",
              "variable_name": "products",
              "value": "Cooking Gas - Gas Only "
            },
          ],
        },
      };
      // print(data);
      Map<String, dynamic> res =
          await PayStackService().initializeTransaction(data);
      PayStackAuthModel payStackAuthModel =
          await PayStackAuthModel.fromJson(res["data"]);
      print(payStackAuthModel);
      iswebViewLoading(false);
      return await payStackAuthModel;
    } catch (e) {
      hasData = false.obs;
      iswebViewLoading(false);
      update();
      throw e;
    }
  }

  Future<void> orderconfirmation() async {
    isLoading(true);
    update();
    if (hasData.value && intializedPayment.authorizationUrl != null) {
      bool paymentVerification = await verifyPayment(
        reference,
      );
      print(paymentVerification);
      if (paymentVerification) {
        showSuccessfulSnackbar("Payment is Successfull");
        isLoading(false);
        Get.offAllNamed(AppPages.SEARCH);
      } else {
        Get.snackbar(
            "Message", "Payment is Unsuccessful. Please Check Credentials",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        Get.offAllNamed(AppPages.SEARCH);
      }
    } else {
      showSnackbar("Proper Credentials", "");
      isLoading(false);
      Get.back();
    }
  }

  Future<bool> verifyPayment(
    String reference,
  ) async {
    Map res = await PayStackService().verifyTransaction(reference);
    if (res["data"]["gateway_response"] == "Successful" ||
        res["gateway_response"] == "Approved") {
      onCompletedTransaction(res);

      statusofTrasaction = true.obs;
    } else {
      onFailedTransaction(res);
      statusofTrasaction = false.obs;
    }

    Map<String, dynamic> ordernotesdata = {
      "note":
          "Payment via Paystack successful (Transaction Reference: ${res["data"]["id"]})"
    };
    Map resi = await ApiService().createOrdernotes(ordernotesdata, orderid);
    if (resi["id"] != null) {}
    Map<String, dynamic> data = {
      "status": statusofTrasaction.value ? "completed" : "Pending payment",
    };
    print(data);
    Map result = await ApiService().updateOrder(data, orderid);
    print(result);
    if (result["status"] == "completed") {
      statusofTrasaction.value = true;
    } else {
      statusofTrasaction.value = false;
    }
    print(statusofTrasaction.value);
    return await statusofTrasaction.value;
  }

  List<dynamic> listAllTransactions() {
    dynamic res = PayStackService().listAllTransactions();
    if (res["statusCode"] == 200) {
      final data = res.data as List;
      if (data.isEmpty) return [];
      return data
          .map((e) =>
              TransactionCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}


// paymentwebviewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(kLightBlue)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith(intializedPayment.authorizationUrl ??
    //             'https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(
    //       intializedPayment.authorizationUrl ?? 'https://flutter.dev'));