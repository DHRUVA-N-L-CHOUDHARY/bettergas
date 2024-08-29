import 'package:bettergas_assignment/app/components/show_loader.dart';
import 'package:bettergas_assignment/app/modules/orders_history/views/order_history_detail_view.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryController>(
      init: OrderHistoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryBlue,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppPages.SEARCH);
                },
                icon: Icon(Icons.arrow_back)),
            iconTheme: IconThemeData(color: kWhiteColor),
            title: Text(
              "Order History",
              style: TextStyle(fontSize: 20, color: kWhiteColor),
            ),
          ),
          body: controller.isLoading.value
              ? ShowLoader()
              : controller.isEmpty.value
                  ? Center(child: Text("No Orders"))
                  : ListView.builder(
                      controller: controller.scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: (controller.orderList.length) + 2,
                      itemBuilder: (BuildContext, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/gas.png',
                                    height: 120.h,
                                    width: 150.w,
                                  ),
                                  Text(
                                    "Better Gas",
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: kPrimaryBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 8.0.r, top: 20.h),
                                child: Center(
                                  child: Text(
                                    "My Orders",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (index == controller.orderList.length+1) {
                          if (controller.isLastPage.value == false) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(
                              child: Text("End of List"),
                            );
                          }
                        } else {
                          return OrderHistoryWidget(
                            bookingDate: DateTime.parse(controller
                                .orderList![index-1].dateCreated!.date
                                .toString()),
                            ordernum:
                                controller.orderList![index-1].id.toString(),
                            orderKey: controller.orderList![index-1].orderKey
                                .toString(),
                            amount: double.parse(
                                controller.orderList[index-1].total.toString()),
                            status:
                                controller.orderList[index-1].status.toString(),
                            locationName:
                                controller.orderList[index-1].location.toString(),
                            paymentMethod: controller
                                .orderList[index-1].paymentMethod
                                .toString(),
                            product: controller.orderList[index-1].productType
                                        .toString() ==
                                    "gas-only"
                                ? "Gas Only"
                                : "Gas + Cylinder",
                          );
                        }
                      },
                    ),
          // bottomNavigationBar: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     controller.pageingnumb > 1
          //         ? Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: GestureDetector(
          //               onTap: () {
          //                 controller.getOrderList((--controller.pageingnumb));
          //               },
          //               child: Text(
          //                 "Previous Page",
          //                 style: TextStyle(
          //                     decoration: TextDecoration.underline,
          //                     color: kPrimaryBlue),
          //               ),
          //             ),
          //           )
          //         : SizedBox.shrink(),
          //     controller.pageingnumb < controller.maxpages
          //         ? Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: GestureDetector(
          //               onTap: () {
          //                 controller.getOrderList((++controller.pageingnumb));
          //               },
          //               child: Text(
          //                 "Next Page",
          //                 style: TextStyle(
          //                     decoration: TextDecoration.underline,
          //                     color: kPrimaryBlue),
          //               ),
          //             ),
          //           )
          //         : SizedBox.shrink(),
          //   ],
          // ),
        );
      },
    );
  }
}

class OrderHistoryWidget extends StatelessWidget {
  final DateTime bookingDate;
  final String ordernum;
  final double amount;
  final String status;
  final String locationName;
  final String paymentMethod;
  final String product;
  final String orderKey;
  const OrderHistoryWidget(
      {super.key,
      required this.bookingDate,
      required this.ordernum,
      required this.orderKey,
      required this.amount,
      required this.status,
      required this.locationName,
      required this.paymentMethod,
      required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(OrderHistoryDetailView(
          orderno: ordernum,
          orderKey: orderKey,
          status: status,
          locationname: locationName,
          paymentmethod: paymentMethod,
          amount: amount,
          product: product,
          bookingDate: "${DateFormat('EEE, d MMMM').format(bookingDate)}",
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: kLightBlue,
          minLeadingWidth: 20,
          title: Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Number : #${ordernum}",
                    style: TextStyle(fontSize: 14.sp)),
                Text(
                    "Order Date : ${DateFormat('EEE, d MMMM').format(bookingDate)}",
                    style: TextStyle(fontSize: 14.sp)),
                Text("Price : ₦$amount", style: TextStyle(fontSize: 14.sp)),
                Text(
                  "Order Status : ${status.capitalizeFirst}",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: status == "pending" ? Colors.red : Colors.green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
