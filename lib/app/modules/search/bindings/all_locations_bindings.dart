import 'package:get/get.dart';

import '../controllers/all_locations_controller.dart';


class AllLocationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllLocationsController>(
      () => AllLocationsController(),
    );
  }
}