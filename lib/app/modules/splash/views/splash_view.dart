import 'package:bettergas_assignment/app/modules/splash/controllers/splash_controller.dart';
import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/Splash_background.png"),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.r),
                child: Center(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: Get.height / 2,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/icons/Logo.png",
                          fit: BoxFit.cover,
                          height: 100.h,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0).h,
                          child: Text(
                            "Welcome to BetterGas",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30.sp),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0.r),
                          child: Text(
                            "It is super easy and convenient to swap your old gas cylinder for a Better Gas cylinder at any of our locations.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.black54),
                          ),
                        ),
                      ),
                      controller.validation.value == false
                          ? Center(
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.r, horizontal: Get.width / 16),
                                color: kWhiteColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: kSecondaryBlue,
                                    ),
                                    borderRadius: BorderRadius.circular(25.r)),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(25.r),
                                //   border: Border.all(color: kSecondaryBlue),
                                // ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAllNamed(AppPages.SIGNUP);
                                      },
                                      child: Container(
                                        width: 2 * Get.width / 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          color: kPrimaryBlue,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(Get.width / 50),
                                          child: Center(
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  color: kWhiteColor,
                                                  fontSize: 20.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAllNamed(AppPages.SIGNIN);
                                      },
                                      child: Container(
                                        width: 2 * Get.width / 5,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(Get.width / 50),
                                          child: Center(
                                            child: Text(
                                              "Sign In",
                                              style: TextStyle(fontSize: 20.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.r, horizontal: Get.width / 16),
                              color: kWhiteColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: kSecondaryBlue,
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(AppPages.SEARCH);
                                  },
                                  child: Container(
                                    width: 3 * Get.width / 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      color: kPrimaryBlue,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(Get.width / 50),
                                      child: Center(
                                        child: Text(
                                          "Start",
                                          style: TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
