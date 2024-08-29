import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(msg, description) {
  Get.snackbar(msg, description,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}

void showSuccessfulSnackbar(msg) {
  Get.snackbar("SuccessFull", msg,
      backgroundColor: kSecondaryBlue,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}
