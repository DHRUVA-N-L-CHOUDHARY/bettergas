import 'dart:ffi';

import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../components/elevatedbutton.dart';
import '../controllers/product_controller.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Get.width,
                    child: Image.asset(
                      "assets/Group 12249.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const Text(
                    "New Order \n Booking",
                    style: TextStyle(color: kWhiteColor, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kCyanColor,
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => Radio(
                              value: 0,
                              activeColor: kWhiteColor,
                              visualDensity: VisualDensity.compact,
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return kWhiteColor;
                                }
                                return kWhiteColor;
                              }),
                              groupValue: controller.selectedProduct.value,
                              onChanged: (option) {
                                controller.selectedProduct.value = option ?? 0;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0.r),
                            child: Text(
                              ' Gas only        ',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kSecondaryBlue,
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => Radio(
                              activeColor: kWhiteColor,
                              value: 1,
                              visualDensity: VisualDensity.compact,
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return kWhiteColor;
                                }
                                return kWhiteColor;
                              }),
                              groupValue: controller.selectedProduct.value,
                              onChanged: (option) {
                                controller.selectedProduct.value = option ?? 0;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.0.r),
                            child: Text(
                              'Gas+Cylinder',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              productDetailCard(controller.name, controller.address, context),
              MyButton(
                ontap: () {
                  Get.dialog(controller.isLoading.value == false
                      ? Center(
                          child: Wrap(
                            children: [
                              Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 22.w, vertical: 24.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.w, vertical: 24.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Order Details",
                                        style: TextStyle(fontSize: 20.sp),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      ListTile(
                                        isThreeLine: true,
                                        visualDensity: VisualDensity.compact,
                                        minLeadingWidth: 0,
                                        contentPadding: const EdgeInsets.all(0),
                                        title: Text(
                                          controller.name,
                                          style: const TextStyle(
                                              color: kPrimaryBlue,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                          controller.address,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      productcarddetails(
                                        "Cylinder Size",
                                        Text(
                                          controller.productsinfo.length != 0
                                              ? controller
                                                  .productsinfo[0].weight
                                                  .toString()
                                              : "12.5 KG",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        isDialog: true,
                                      ),
                                      productcarddetails(
                                        "Pick-up Date",
                                        Text(
                                          "${DateFormat('EEE, d MMMM').format(
                                            controller.pickedDate ??
                                                DateTime.now(),
                                          )}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        isDialog: true,
                                      ),
                                      productcarddetails(
                                        "Price",
                                        Text(
                                          controller.selectedProduct.value == 0
                                              ? "₦${controller.formatter.format((controller.productsinfo.length != 0 ? double.parse(controller.productsinfo[1].displayPrice.toString()) : 280.00) * controller.selectedQuantity.value)}"
                                              : "₦${controller.formatter.format((controller.productsinfo.length != 0 ? double.parse(controller.productsinfo[0].displayPrice.toString()) : 380.00) * controller.selectedQuantity.value)}",
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        isDialog: true,
                                      ),
                                      productcarddetails(
                                        "Quantity",
                                        Text(
                                          controller.selectedQuantity.value
                                              .toString(),
                                          style: const TextStyle(
                                              color: kPrimaryBlue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        isDialog: true,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Obx(() => controller.isLoading.value
                                          ? CircularProgressIndicator()
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            kPrimaryBlue),
                                              ),
                                              onPressed: () async {
                                                bool verifyorder = await controller.createOrder(
                                                    controller.selectedProduct.value == 0
                                                        ? "${((controller.productsinfo.length != 0 ? (double.parse(controller.productsinfo[1].displayPrice.toString()) * 10) : 28000.00) * controller.selectedQuantity.value)}"
                                                        : "${((controller.productsinfo.length != 0 ? (double.parse(controller.productsinfo[0].displayPrice.toString()) * 10) : 38000.00) * controller.selectedQuantity.value)}",
                                                    controller
                                                        .selectedQuantity.value,
                                                    controller.selectedProduct.value == 0
                                                        ? (controller
                                                                    .productsinfo
                                                                    .length !=
                                                                0
                                                            ? controller
                                                                .productsinfo[1]
                                                                .variationId
                                                                .toString()
                                                            : "56")
                                                        : (controller
                                                                    .productsinfo
                                                                    .length !=
                                                                0
                                                            ? controller
                                                                .productsinfo[0]
                                                                .variationId
                                                                .toString()
                                                            : "55"));
                                                if (verifyorder) {
                                                  Get.back();
                                                  Get.toNamed(
                                                    AppPages.PAYMENT,
                                                    arguments: {
                                                      "orderid":
                                                          controller.orderid,
                                                      "orderkey":
                                                          controller.orderkey,
                                                      "amount": controller
                                                                  .selectedProduct
                                                                  .value ==
                                                              0
                                                          ? "${((controller.productsinfo.length != 0 ? (double.parse(controller.productsinfo[1].displayPrice.toString()) * 10) : 28000.00) * controller.selectedQuantity.value)}"
                                                          : "${((controller.productsinfo.length != 0 ? (double.parse(controller.productsinfo[0].displayPrice.toString()) * 10) : 38000.00) * controller.selectedQuantity.value)}",
                                                    },
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : CircularProgressIndicator());
                },
                text: "Buy Gas",
              )
            ],
          ),
        );
      },
    );
  }

  Widget productDetailCard(
      String locationName, String locationAddress, BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.all(20.r),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: kLightBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              visualDensity: VisualDensity.compact,
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                locationName,
                style: const TextStyle(
                    color: kPrimaryBlue, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                locationAddress,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(AppPages.SEARCH);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Change Location",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            productcarddetails(
              "Cylinder Size",
              Container(
                height: 35.h,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Container(
                        padding: EdgeInsets.only(left: 12.0.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: DropdownButton<String>(
                          value: controller.selectedValue.value,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                          underline: SizedBox(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedValue.value = newValue;
                            }
                          },
                          items: controller.uniqueList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                "$value KG",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // productcarddetails(
            //   "Pick-up Date",
            //   GestureDetector(
            //     onTap: () async {
            //       // controller.getCurrentDate(context);
            //     },
            //     child: Padding(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 0.0.r, vertical: 8.r),
            //       child: Row(
            //         children: [
            //           Text(
            //             " ${DateFormat('EEE, d MMMM').format(controller.pickedDate ?? DateTime.now())}",
            //             style: TextStyle(
            //                 fontSize: 14.sp, fontWeight: FontWeight.w300),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            productcarddetails(
              "Operating hours",
              GestureDetector(
                onTap: () async {
                  // controller.getCurrentDate(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.0.r, vertical: 8.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 170.w,
                        child: Text(
                          "9:00 AM to 6:00 PM (Monday to Saturday)",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            productcarddetails(
              "Price",
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0.r, vertical: 8.r),
                child: Obx(
                  () => Text(
                    ( controller.selectedProduct.value == 0
                        ? "₦${controller.formatter.format((controller.productsinfo.length != 0 ? double.parse(controller.productsinfo[1].displayPrice.toString()) : 280.00) * controller.selectedQuantity.value)}"
                        : "₦${controller.formatter.format((controller.productsinfo.length != 0 ? double.parse(controller.productsinfo[0].displayPrice.toString()) : 380.00) * controller.selectedQuantity.value)}"),
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            productcarddetails(
              "Quantity",
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0.r, vertical: 8.r),
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: controller.decrement,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                              )),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.r, horizontal: 4.r),
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.r, horizontal: 10.r),
                        child: Text(
                          "${controller.selectedQuantity.value}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.increment,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.r),
                                bottomRight: Radius.circular(5.r),
                              )),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.r, horizontal: 4.r),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget productcarddetails(String infoHeading, Widget infocontent,
      {bool isDialog = false}) {
    return Row(
      children: [
        SizedBox(width: Get.width / 3, child: Text(infoHeading)),
        const Text(":"),
        Container(
            margin: EdgeInsets.only(left: 10.0.r),
            width: isDialog ? Get.width / 3 - 10.r : Get.width / 2 - 10.r,
            child: infocontent),
      ],
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(10.r),
        padding: EdgeInsets.all(5.r),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          gradient: RadialGradient(
              colors: kDarkGradient, center: Alignment.centerRight),
        ),
        child: Text(
          "5 KG",
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
