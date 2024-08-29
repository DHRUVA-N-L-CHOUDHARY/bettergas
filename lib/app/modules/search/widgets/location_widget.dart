import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/common_utils.dart';
import '../../../data/models/Product_info_model.dart';

class LocationTile extends StatelessWidget {
  final void Function() onTap;
  final String name;
  final String image;
  final String termid;
  final String address;
  final String distance;
  final String phonenumb;
  final List<ProductInfoModel> products_info;
  const LocationTile(
      {super.key,
      required this.onTap,
      required this.name,
      required this.image,
      required this.address,
      required this.termid,
      required this.distance,
      required this.phonenumb,
      required this.products_info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 8.0.w),
      child: Card(
        color: kLightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              tileColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(8.0),
              titleAlignment: ListTileTitleAlignment.top,
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: 4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25).r,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5).r,
                child: Image.network(
                  fit: BoxFit.fitHeight,
                  image,
                  cacheHeight: 100,
                  cacheWidth: 100,
                  height: 120.h,
                  width: 60.w,
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0).r,
                    child: Text(
                      name.length > 20 ? "${name.substring(0, 17)}..." : name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0).r,
                        child: Image.asset(
                          "assets/marker.png",
                          height: 10.h,
                          width: 10.h,
                        ),
                      ),
                      Text(
                        address.length > 25
                            ? "${address.substring(0, 23)}..."
                            : address,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      makePhoneCall(phonenumb);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0).r,
                          child: Image.asset(
                            "assets/phone-call.png",
                            height: 10.h,
                            width: 10.h,
                          ),
                        ),
                        Text(
                          phonenumb,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  (distance == "" || distance == "null")
                      ? SizedBox.shrink()
                      : SizedBox(
                          width: 60.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(
                                  "assets/direction.png",
                                  height: 10.h,
                                  width: 10.w,
                                ),
                              ),
                              Text(
                                distance.length > 5
                                    ? "${distance.substring(0, 4)}mi"
                                    : "$distance mi",
                                   
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Get.toNamed(
                  AppPages.PRODUCT,
                  arguments: {
                    "name": name,
                    "address": address,
                    "term_id": termid,
                    "product": products_info
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                fixedSize: Size(200.w, 10.h),
                backgroundColor: kPrimaryBlue,
                visualDensity: const VisualDensity(
                  vertical: -2.0,
                  horizontal: -4.0,
                ),
              ),
              child: Text(
                "Buy Gas",
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 15.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
