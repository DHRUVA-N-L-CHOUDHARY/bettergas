import 'package:bettergas_assignment/app/data/remote/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../search/models/location.dart';

class DashBoardController extends GetxController {
  var isSelected = false.obs;
  var selectedOption = 'Gas'.obs;
  late GlobalKey<ScaffoldState> scaffoldState;
  var count = 0.obs;
  final Rx<TextEditingController> searchController =
      TextEditingController().obs;
  final RxString search = "".obs;
  final List<Location> locations = <Location>[].obs;
  final List<Location> searchLocations = <Location>[].obs;

  @override
  Future<void> onInit() async {
    scaffoldState = GlobalKey<ScaffoldState>();
    print("------------------------");
    var res = await ApiService().fetchProductsList();
    print(res);
    super.onInit();
  }

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  void onChanged(String value) {
    search.value = value;
    print(search.value);
    searchLocations.clear();
    for (var item in locations) {
      if (item.name!.toLowerCase().contains(search.value.toLowerCase())) {
        searchLocations.add(item);
      }
    }
  }

  void selectOption(String option) {
    isSelected.value = option == 'Gas';
    selectedOption.value = option;
  }

  RxString selectedLocation = "".obs;
  RxString searchText = "".obs;
  void handleLocationSelection(String location) {
    selectedLocation.value = location;
  }
}
