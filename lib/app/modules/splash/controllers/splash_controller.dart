
import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_service.dart';

class SplashController extends GetxController {
  RxBool validation = false.obs;

  @override
  void onInit() async{
    super.onInit();
    validation.value = await AppService.isValidString(MySharedPref.getUserId()); 
    print(validation.value);
    update();
  }
}
