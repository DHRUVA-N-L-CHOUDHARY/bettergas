import 'package:bettergas_assignment/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/elevatedbutton.dart';
import '../../../components/show_loader.dart';
import '../../../components/text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: controller.isLoading.value ? ShowLoader() : Center(
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
                      "Let's sign you in ",
                      style: TextStyle(
                        fontSize: 30,
                        color: controller.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Sign in with your data that you have entered during your registration',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      textController: controller.emailController,
                      firstImage: 'assets/email.png',
                      firstText: 'Email ID',
                      hintText: 'Enter Your Email ID',
                      isPassword: false,
                      isRequired: true,
                    ),
                    MyTextField(
                      textController: controller.passwordController,
                      firstImage: 'assets/padlock.png',
                      firstText: 'Password',
                      hintText: 'Enter Your Password',
                      isPassword: true,
                      isRequired: true,
                      isObscure: controller.isPasswordView,
                      suffixIcon: IconButton(
                                onPressed: () {
                                    controller.changepasswordview();
                              
                                },
                                icon: Icon(controller.isPasswordView
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined)),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.forgotpassworddialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Obx(
                    //       () => Checkbox(
                    //         value: controller.rememberMe.value,
                    //         onChanged: (bool? value) {
                    //           controller.setRemeberState(value!);
                    //         },
                    //         activeColor: controller.textColor,
                    //       ),
                    //     ),
                    //     const Text(
                    //       'Remember me',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    MyButton(
                      ontap: () {
                        controller.loginCustomer(
                            controller.emailController.text,
                            controller.passwordController.text);
                      },
                      text: 'Sign In',
                    ),
                    // CustomTextButton(
                    //     imagePath: 'assets/search.png',
                    //     buttonText: 'Sign In with Google',
                    //     onPressed: () => {}),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        GestureDetector(
                          onTap: () => {Get.toNamed(AppPages.SIGNUP)},
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: controller.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
