import 'package:bettergas_assignment/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';


class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(
      () => DashBoardController(),
    );
  }
}