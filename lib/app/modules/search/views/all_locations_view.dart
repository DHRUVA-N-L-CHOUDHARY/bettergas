import 'dart:async';

import 'package:bettergas_assignment/app/modules/search/controllers/all_locations_controller.dart';
import 'package:bettergas_assignment/app/modules/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../components/show_loader.dart';
import '../widgets/location_widget.dart';
import '../widgets/searchbar_widget.dart';

class AllLocationsView extends StatelessWidget {
  const AllLocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllLocationsController>(
        init: AllLocationsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              toolbarHeight: Get.height / 10,
              centerTitle: false,
              title: Text(
                "All Locations",
                style: TextStyle(color: kWhiteColor),
              ),
              flexibleSpace: Container(
                height: Get.height / 7,
                decoration: BoxDecoration(
                  color: kSecondaryBlue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r)),
                ),
              ),
            ),
            body: controller.isLoading.value == true
                ? ShowLoader()
                : ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.locations.length > 9
                        ? controller.locations.length + 2
                        : controller.locations.length + 1,
                    itemBuilder: (context, index) {
                      print(index);
                      print(controller.nonearbyLoc.value);
                      
                      if (index == 0) {
                        return Column(
                          children: [
                            SearchBarWidget(
                              isSearch: controller.isSearch.value,
                              textEditingController:
                                  controller.textEditingController,
                              onChanged: (value) {
                                controller.getData(1, true);
                                controller.isSearch.value = true;
                                if (controller.textEditingController.text.isEmpty) {
                                  controller.isSearch.value = false;
                                }
                              },
                            ),
                            if(controller.nonearbyLoc.value)
                            SizedBox(
                                height: Get.height / 3,
                              ),
                            if(controller.nonearbyLoc.value)
                              Text("No Record Nearby this Location"),
                          ],
                        );
                      }  
                      else if (controller.nonearbyLoc.value) {
                        return Center(
                          child: Column(
                            children: [
                              
                            ],
                          ),
                        );
                      }
                      else if (controller.locations.length < 9 &&
                          index == controller.locations.length + 1) {
                        return Center(
                          child: Column(
                            children: [
                              Text("No Record Nearby this Location"),
                            ],
                          ),
                        );
                      } else if (index == controller.locations.length + 1) {
                        if (controller.pageingnumb <= controller.maxpages) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Center(
                            child: Text("Reached end of list"),
                          );
                        }
                      } else {
                        return LocationTile(
                          onTap: () {},
                          termid:
                              controller.locations[index - 1].termId.toString(),
                          image:
                              controller.locations[index - 1].image.toString(),
                          name: controller.locations[index - 1].name.toString(),
                          address: controller.locations[index - 1].address
                              .toString(),
                          distance: "",
                          phonenumb:
                              controller.locations[index - 1].phone.toString(),
                          products_info: controller.products_info,
                        );
                      }
                      
                    }),
            // ListView(
            //     children: [
            // controller.nonearbyLoc.value
            //     ? Center(
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: Get.height / 3,
            //             ),
            //             Text("No Record Nearby this Location"),
            //           ],
            //         ),
            //       )
            //           : Obx(() {
            //               if (controller.isLoading.value == true) {

            //               };
            //               return ListView.builder(
            //                   shrinkWrap: true,
            //                   controller: controller.scrollController,
            //                   itemCount: controller.locations.length,
            //                   itemBuilder: (context, index) {
            //                     return LocationTile(
            //                       onTap: () {},
            //                       termid: controller.locations[index].termId
            //                           .toString(),
            //                       image: controller.locations[index].image
            //                           .toString(),
            //                       name: controller.locations[index].name
            //                           .toString(),
            //                       address: controller
            //                           .locations[index].address
            //                           .toString(),
            //                       distance: "",
            //                       phonenumb: controller
            //                           .locations[index].phone
            //                           .toString(),
            //                       products_info: controller.products_info,
            //                     );
            //                   });
            //             })
            // ],
            // ),
            // bottomNavigationBar: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     controller.pageingnumb > 2
            //         ? Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: GestureDetector(
            //               onTap: () {
            //                 controller.getData((--controller.pageingnumb));
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
            //                 controller.getData((++controller.pageingnumb));
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
        });
  }
}

Widget locationselection(BuildContext context) {
  return GetBuilder<SearchScreenController>(builder: (c) {
    return InkWell(
      onTap: () {
        c.getCurrentPosition();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 24,
                ),
              ],
            ),
            Expanded(
                child: Row(
              children: [
                Text(
                    (c.currentAddress).isEmpty
                        ? "Select Location"
                        : c.currentAddress,
                    style: const TextStyle(color: Colors.red)),
                (c.currentAddress.toString().trim()).isEmpty
                    ? Container()
                    : const Text(" (Edit) ",
                        style: TextStyle(color: Colors.black))
              ],
            )),
          ],
        ),
      ),
    );
  });
}
