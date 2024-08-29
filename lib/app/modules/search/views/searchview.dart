import 'package:bettergas_assignment/app/components/show_loader.dart';
import 'package:bettergas_assignment/app/data/local/my_shared_pref.dart';
import 'package:bettergas_assignment/app/modules/search/widgets/location_widget.dart';
import 'package:bettergas_assignment/app/modules/search/controllers/search_controller.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/drawer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      init: SearchScreenController(),
      builder: (controller) {
        return Scaffold(
          drawer: SideDrawer(),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kWhiteColor),
            toolbarHeight: Get.height / 10,
            centerTitle: false,
            title: Text(
              "Hi, ${MySharedPref.getName()}",
              style: TextStyle(color: kWhiteColor),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  controller.handlePressButton(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "change",
                        style: TextStyle(color: kWhiteColor, fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: kWhiteColor,
                            size: 20,
                          ),
                          Text(
                            controller.currentAddress.toString(),
                            style: const TextStyle(
                                color: kWhiteColor, fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            flexibleSpace: Container(
              height: Get.height / 7,
              decoration: const BoxDecoration(
                color: kSecondaryBlue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
            ),
          ),
          body: controller.isLoading.value == true
              ? ShowLoader()
              : ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text(
                        'Buy Gas',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                        child: Text(
                      "Find a Micro Distribution Center (MDC) near you",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    )),
                    searchBox(),
                    controller.nonearbyLoc.value
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height / 3,
                                ),
                                Text("No Record Nearby this Location"),
                              ],
                            ),
                          )
                        : Obx(() {
                            if (controller.isLoading.value == true) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.locations.length,
                                itemBuilder: (context, index) {
                                  return LocationTile(
                                    onTap: () {},
                                    termid: controller.locations[index].termId
                                        .toString(),
                                    image: controller.locations[index].image
                                        .toString(),
                                    name: controller.locations[index].name
                                        .toString(),
                                    address: controller.locations[index].address
                                        .toString(),
                                    distance: controller
                                        .locations[index].distance
                                        .toString(),
                                    phonenumb: controller.locations[index].phone
                                        .toString(),
                                    products_info: controller.products_info,
                                  );
                                });
                          })
                  ],
                ),
        );
      },
    );
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

  Widget searchBox() {
    return GetBuilder<SearchScreenController>(
      init: SearchScreenController(),
      builder: (controller) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade200),
          child: TextFormField(
            controller: controller.textEditingController,
            // onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Enter your City or State',
              // prefixIcon: const Icon(Icons.location_on_outlined),
              prefixIcon: IconButton(
                onPressed: () {
                  // if (isSearch) {
                  //   textEditingController?.clear();
                  //  clear != null ? clear!() : "";
                  // }
                },
                icon: Icon(
                  // isSearch ? Icons.close :
                  Icons.search,
                  color: kPrimaryBlue,
                  size: 20.sp,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
            ),
          ),
        );
      },
    );
  }
}
