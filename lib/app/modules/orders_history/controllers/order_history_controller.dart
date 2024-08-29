import 'dart:convert';

import 'package:bettergas_assignment/app/data/local/my_shared_pref.dart';
import 'package:bettergas_assignment/app/data/remote/api_service.dart';
import 'package:bettergas_assignment/app/modules/orders_history/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderHistoryController extends GetxController {
  OrdersModel ordersmodel = OrdersModel();
  // NumberFormat formatter = ;
  final ScrollController scrollController = ScrollController();
  List<Data> orderList = new List.empty(growable: true);
  RxBool isLoading = false.obs;
  RxBool isEmpty = true.obs;
  RxBool isLastPage = false.obs;
  int pageingnumb = 1;
  int maxpages = 0;
  Future<void> getOrderList(int pagenumber) async {
    // isLoading(true);
    update();
    String getOrderCustoms =
        "?user=${MySharedPref.getUserId()}&page=${pagenumber}";
    dynamic res = await ApiService().getOrdersList(getOrderCustoms);
    Map<String, dynamic> response = jsonDecode(res.body);
    print(response);
    ordersmodel = OrdersModel();
    maxpages = int.parse(response["max_pages"].toString());
    update();
    if ((int.parse(response["max_pages"].toString()) >=
            int.parse(pagenumber.toString())) &&
        (int.parse(response["max_pages"].toString()) > 0)) {
      if (response["total_orders"] != 0) {
        ordersmodel = OrdersModel.fromJson(response);
        ordersmodel.data?.forEach((element) {
          orderList.add(element);
        });
        print(orderList.length);
        orderList.forEach((element) {
          print(element.id);
        });
        isEmpty(false);
        update();
      }
    } else {
      // isLoading(false);
      // update();
      isEmpty(true);
      update();
    }
    // isLoading(false);
    update();
  }

  @override
  Future<void> onInit() async {
    isLoading(true);
    update();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          pageingnumb < (maxpages)) {
        print(maxpages);
        pageingnumb += 1;
        print(pageingnumb);
        update();
        await getOrderList(pageingnumb);
        if (pageingnumb >= maxpages) {
          isLastPage = true.obs;
        }
        else{
          isLastPage = false.obs;
        }
        update();
      }
    });
    await getOrderList(1);
    isLoading(false);
    update();
    super.onInit();
  }
}
