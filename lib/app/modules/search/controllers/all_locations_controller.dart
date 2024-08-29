import 'dart:convert';

import 'package:bettergas_assignment/app/modules/search/models/all_locations_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../data/models/Product_info_model.dart';
import '../../../data/models/nearby_locations_model.dart';
import '../../../data/remote/api_service.dart';

class AllLocationsController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxString search = "".obs;
  final RxBool isLoading = false.obs;
  RxString city = "Select Location".obs;
  RxBool getloc = true.obs;
  RxBool nonearbyLoc = true.obs;
  RxBool isSearch = false.obs;
  String? lati;
  String? longi;
  RxString radius = "100".obs;
  List<ProductInfoModel> products_info = List.empty(growable: true);
  RxString? kGoogleApiKey = "AIzaSyAPNs4LbF8a3SJSG7O6O9Ue_M61inmaBe0".obs;
  String currentAddress = "Choose Location";
  RxBool showLocLoader = false.obs;
  int pageingnumb = 1;
  int maxpages = 0;
  int totalOrders = 0;
  Position currentPosition = Position(
      longitude: 9.15635270,
      latitude: 7.35294650,
      timestamp: DateTime.now(),
      accuracy: 100,
      altitude: 0,
      altitudeAccuracy: 100,
      heading: 0,
      headingAccuracy: 100,
      speed: 0,
      speedAccuracy: 100);
  List<AllLocationsModel> locations = List.empty(growable: true);

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading(true);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          pageingnumb <= (maxpages)) {
        await getData(++pageingnumb, false);
      }
    });
    await getData(1, false);
    isLoading(false);
    update();
  }

  void clear() {
    locations = [];
    getData(1, true);
    isSearch.value = true;
    if (textEditingController.text.isEmpty) {
      isSearch.value = false;
    }
  }

  Future<void> getData(int pagenumber, bool search) async {
    try {
      // isLoading(true);
      update();
      dynamic res;
      if (search && textEditingController.text != "") {
        if (isSearch.value == false) {
          pageingnumb = 1;
        }
        isSearch.value = true;
        update();
        res = await ApiService().getAllSearchLocations(
            {"search": textEditingController.text, "page": pagenumber}, true);
        res = jsonDecode(res.body);
        print(res.toString());
        nonearbyLoc(true);
        update();
        locations = [];
      } else {
        if (isSearch.value == true) {
          pageingnumb = 1;
        }
        isSearch.value = false;
        res = await ApiService().getAllLocations(pagenumber);
        res = jsonDecode(res.body);
        print(res["terms"].toString());
      }
      if (res["terms"] != null) {
        print("---------------------+++++++");
        maxpages = int.parse(res["max_num_pages"].toString());
        totalOrders = int.parse(res["total_items"].toString());
        print(pagenumber);
        update();
        if (res["product"] != null) {
          List<dynamic> variations = res["product"]["variations"];
          for (var variation in variations) {
            products_info.add(ProductInfoModel(
              variationId: variation["variation_id"].toString(),
              displayPrice: variation["display_price"].toString(),
              weight: variation["weight"].toString(),
            ));
          }
        }
        for (var item in res["terms"]) {
          if (item['name'] != null) {
            String filteredName = item["name"]
                .split(" ")
                .where((word) => (word != "Better" && word != "Gas"))
                .join(" ");
            print(filteredName);
            item["name"] = filteredName;
            locations.add(AllLocationsModel.fromJson(item));
            update();
          }
        }
        // isLoading(false);
        update();
      } else {
        nonearbyLoc(true);
        // isLoading(true);
        update();
      }
      if (locations.length != 0) {
        nonearbyLoc(false);
        // isLoading(true);
        update();
      }
      print(nonearbyLoc.value);
      // isLoading(false);
      update();
    } catch (e) {
      // isLoading(true);
      nonearbyLoc(true);
      update();
      rethrow;
    }
  }
}
