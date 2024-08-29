import 'dart:async';

import 'package:bettergas_assignment/app/data/remote/api_service.dart';
import 'package:bettergas_assignment/app/modules/sign_in/models/sign_in_model.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../utils/common_utils.dart';
import '../../../components/snackBar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_service.dart';
import '../models/get_customer_details_model.dart';

class SignInController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  TextEditingController emailFPCtrl = TextEditingController();
  late String email;
  late String password;
  late RxBool rememberMe = false.obs;
  late Color textColor = const Color(0xFF3463B4);
  RxBool isLoading = false.obs;
  bool isPasswordView = true;

  void changepasswordview() {
    isPasswordView = !isPasswordView;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading(true);
    update();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isLoading(false);
    update();
  }

  void setRemeberState(bool value) {
    rememberMe = value.obs;
    update();
  }

  Future<void> navigate() async {
    String? token = MySharedPref.getToken();
    if (AppService.isValidString(token)) {
      Get.offAllNamed(AppPages.DASHBOARD);
    }
  }

  Future<void> loginCustomer(String username, String password) async {
    isLoading(true);
    update();
    FocusManager.instance.primaryFocus?.unfocus();
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      showSnackbar(
          "Required Fields are Missing", "Items marked * are mandatory");
      isLoading(false);
      update();
      return;
    }
    try {
      Map<String, dynamic> data = {
        "user_login": username,
        "user_password": password,
        "role": "customer"
      };
      print(data);
      Map res = await ApiService().login(data);
      print(res);
      if (res["status"] == true) {
        res = res["data"];
        MySharedPref.setEmail(res["email"].toString());
        MySharedPref.setName(res["display_name"].toString());
        MySharedPref.setUserId(res["ID"].toString());
        MySharedPref.setPhone(res["phone_number"].toString());
        MySharedPref.setAddress(res["address"].toString());
        Get.snackbar(
          'Message',
          "Login Successful",
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10.0,
          margin: const EdgeInsets.all(10.0),
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
        isLoading(false);
        update();
        Timer(const Duration(seconds: 2), () {
          Get.offAllNamed(AppPages.SEARCH);
        });
      } else {
        print(res["message"]);
        Get.snackbar(
          'Error',
          res["message"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10.0,
          margin: const EdgeInsets.all(10.0),
          isDismissible: true,
          duration: const Duration(seconds: 3),
        );
        isLoading(false);
        update();
      }
    } catch (e) {
      rethrow;
    }
    isLoading(false);
    update();
  }

  void forgotpassworddialog() {
    Get.dialog(Center(
      child: Wrap(
        children: [
          Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Forgot password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.2)),
                    child: TextField(
                      controller: emailFPCtrl,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          hintText: "johndoe@hotmail.com",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kPrimaryBlue)),
                      onPressed: () async {
                        Get.back();
                        await forgotpassword();
                        // Get.back();
                        // Get.back();
                      },
                      child: const Text(
                        "Send me password",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> forgotpassword() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (emailFPCtrl.text.trim().isEmpty) {
      showSnackbar("Email", "Email address is missing");
      return;
    } else if (emailFPCtrl.text.trim().isNotEmpty &&
        !validateEmail(emailFPCtrl.text.trim())) {
      showSnackbar("Valid email", "Enter a valid email address");
      return;
    } else {
      var data = {"email": emailFPCtrl.text.trim()};
      debugPrint("fp data $data");
      String res = await ApiService().forgotPassword(emailFPCtrl.text);
      Get.snackbar("Server Response", "${res}",
          backgroundColor: kSecondaryBlue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
