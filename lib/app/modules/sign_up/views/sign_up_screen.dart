import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/elevatedbutton.dart';
import '../../../components/show_loader.dart';
import '../../../components/text_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: controller.isLoading.value
                ? ShowLoader()
                : Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/gas.png',
                            width: 150,
                            height: 150,
                            filterQuality: FilterQuality.high,
                          ),
                          Text(
                            "Let's register you ",
                            style: TextStyle(
                              fontSize: 30,
                              color: controller.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Let's register your account with below given information",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            textController: controller.nameController,
                            firstImage: 'assets/user.png',
                            firstText: 'Name',
                            hintText: 'Enter Your Name',
                            isRequired: true,
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.phoneController,
                            firstImage: 'assets/telephone.png',
                            firstText: 'Phone Number',
                            hintText: 'Enter Your Phone Number',
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            textInputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11)
                            ],
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.emailController,
                            firstImage: 'assets/email.png',
                            firstText: 'Email',
                            hintText: 'Enter Your Email',
                            isRequired: true,
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.passwordController,
                            firstImage: 'assets/padlock.png',
                            firstText: 'Password',
                            hintText: 'Enter Your Password',
                            keyboardType: TextInputType.visiblePassword,
                            isRequired: true,
                            isPassword: true,
                            isObscure: controller.isPasswordView,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.changepasswordview();
                                },
                                icon: Icon(controller.isPasswordView
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined)),
                          ),
                          MyTextField(
                              textController:
                                  controller.confirmPasswordController,
                              firstImage: 'assets/padlock.png',
                              firstText: 'Confirm Password',
                              hintText: 'Confirm your Password',
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              isRequired: true,
                              isObscure: controller.isConfirmPasswordView,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.changeConfirmpasswordview();
                                  },
                                  icon: Icon(controller.isConfirmPasswordView
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined))),
                          MyButton(
                            ontap: () {
                              controller.signUp();
                            },
                            text: 'Register',
                          ),
                          // CustomTextButton(
                          //     imagePath: 'assets/search.png',
                          //     buttonText: 'Sign Up with Google',
                          //     onPressed: () => {}),
                           SizedBox(height: 20.h),
                           RichText(
                text: TextSpan(children: <TextSpan>[
                    TextSpan(
                    text: "*",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  ),
                  TextSpan(
                    text: " Marked items are mandatory",
                    style:  TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                 
                ]),
              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account? '),
                              GestureDetector(
                                onTap: () => {
                                  Get.toNamed(AppPages.SIGNIN),
                                },
                                child: Text('Login here',
                                    style: TextStyle(
                                      color: controller.textColor,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
