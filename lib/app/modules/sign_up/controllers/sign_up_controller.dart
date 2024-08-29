import 'dart:async';

import 'package:bettergas_assignment/app/components/snackBar.dart';
import 'package:bettergas_assignment/app/data/local/my_shared_pref.dart';
import 'package:bettergas_assignment/app/data/models/customer_model.dart';
import 'package:bettergas_assignment/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/remote/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../../../utils/common_utils.dart';
import '../../sign_in/models/sign_in_model.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  RxBool isLoading = false.obs;

  SignInController signInController = SignInController();
  bool isPasswordView = true;
  bool isConfirmPasswordView = true;
  late Color textColor = const Color(0xFF3463B4);

  void changepasswordview() {
    isPasswordView = !isPasswordView;
    update();
  }

  void changeConfirmpasswordview() {
    isConfirmPasswordView = !isConfirmPasswordView;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  Future<void> signUp() async {
    isLoading(true);
    update();
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      if (nameController.text.trim().isEmpty ||
          phoneController.text.trim().isEmpty ||
          emailController.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty ||
          confirmPasswordController.text.trim().isEmpty) {
        showSnackbar(
            "Required Fields are Missing", "Items marked * are mandatory");
        isLoading(false);
        update();
        return;
      } else if (nameController.text.isNumericOnly) {
        showSnackbar("Valid Name is Required", "Enter a Vaild Name");
        isLoading(false);
        update();
      } else if (phoneController.text.length != 11) {
        showSnackbar("Phone Number", "Enter correct phone number");
        isLoading(false);
        update();
        return;
      } else if (emailController.text.trim().isNotEmpty &&
          !validateEmail(emailController.text.trim())) {
        showSnackbar("Email", "Enter valid email address.");
        isLoading(false);
        update();
        return;
      } else if (confirmPasswordController.text.trim().isNotEmpty &&
          confirmPasswordController.text.trim() !=
              passwordController.text.trim()) {
        showSnackbar("Password", "Password and Confirm Password must match.");
        isLoading(false);
        update();
        return;
      } else if (isPasswordCompliant(
              passwordController.text.trim().toString()) ==
          false) {
        Get.snackbar("Please provide valid Password",
            "Password should have minimum of 1 special Character, 1 Uppercase letter, 1 lowercase letter, 1 digit and minimum length of 8 characters.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
        return;
      } else {
        if (passwordController.text == confirmPasswordController.text) {
          Map res = await ApiService().signUp({
            "email": emailController.text,
            "password": passwordController.text,
            "phone": phoneController.text,
            "name": nameController.text,
            "role": "customer"
          });
          if (res["status"] == true) {
            if (res["data"] != null) {
              res = res["data"];
              MySharedPref.setUserId(res["ID"].toString());
              MySharedPref.setPhone(res["phone_number"].toString());
              MySharedPref.setName(res["display_name"].toString());
              MySharedPref.setEmail(res["email"].toString());
              MySharedPref.setAddress(res["address"].toString());
              Get.snackbar("Register successfully",
                  "${res["display_name"]} registration is successfull.",
                  backgroundColor: kPrimaryBlue,
                  isDismissible: false,
                  snackPosition: SnackPosition.BOTTOM);
              isLoading(false);
              update();
              Get.offAllNamed(AppPages.SEARCH);
            }
          } else {
            showSnackbar('Error', "${res["message"]}");
            isLoading(false);
            update();
            return;
          }
        } else {
          showSnackbar('Provide correct crentidals', "");
          isLoading(false);
          update();
          return;
        }
      }
    } catch (e) {
      rethrow;
    }
    isLoading(false);
    update();
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
