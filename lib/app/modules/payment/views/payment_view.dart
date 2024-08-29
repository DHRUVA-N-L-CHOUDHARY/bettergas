

import 'package:bettergas_assignment/app/components/show_loader.dart';
import 'package:bettergas_assignment/app/modules/payment/controllers/payment_controller.dart';
import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/colors.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Make Payment"),
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //   onPressed: () async {
              //     if (controller.iswebViewLoading.value == false &&
              //         controller.hasData.value &&
              //         controller.intializedPayment.authorizationUrl != null) {
              //       bool paymentVerification = await controller.verifyPayment(
              //         controller.reference,
              //       );
              //       print(paymentVerification);
              //       if (paymentVerification) {
              //         showSuccessfulSnackbar("Payment is Successfull");
              //         Get.offAllNamed(AppPages.SEARCH);
              //       } else {
              //         Get.snackbar("Message",
              //             "Payment is Unsuccessful. Please Check Credentials",
              //             backgroundColor: Colors.red,
              //             colorText: Colors.white,
              //             snackPosition: SnackPosition.BOTTOM);
              //         Navigator.of(context).pop();
              //       }
              //     } else {
              //       showSnackbar("Proper Credentials");
              //       Navigator.of(context).pop();
              //     }
              //   },
              //   icon: const Icon(Icons.close),
              // ),
            ),
            body: controller.isLoading.value == true
                ? ShowLoader()
                : (controller.iswebViewLoading.value == false &&
                        controller.hasData.value &&
                        controller.intializedPayment.authorizationUrl != null)
                    ? WebViewWidget(
                        controller: WebViewController()
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..setBackgroundColor(kLightBlue)
                          ..setNavigationDelegate(
                            NavigationDelegate(
                              onProgress: (int progress) {
                                // Update loading bar.
                              },
                              onPageStarted: (String url) {},
                              onPageFinished: (String url) {},
                              onWebResourceError: (WebResourceError error) {},
                              onNavigationRequest: (NavigationRequest request) {
                                if (request.url.startsWith(
                                    controller.refrenceUrl.value ??
                                        "https://www.youtube.com/")) {
                                  return NavigationDecision.prevent;
                                }
                                return NavigationDecision.navigate;
                              },
                            ),
                          )
                          ..loadRequest(
                            Uri.parse(controller.refrenceUrl.value ??
                                "https://flutter.dev"),
                          ),
                      )
                    : controller.iswebViewLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: Text(
                                "There is an issue with the payment please try again later")),
            bottomNavigationBar:
            Padding(
              padding: EdgeInsets.all(16.0.dg),
              child: TextButton(
                onPressed: () {
                  Get.offNamed(AppPages.SEARCH);
                },
                child: Text(
                  "Home",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Container(
            //       height: Get.height / 15,
            //       width: (Get.width / 3) * 2,
            //       child: Container(
            //         child: GestureDetector(
            //           onTap: () async {
            //             Get.offAllNamed(AppPages.SEARCH);
            //           },
            //           child: Container(
            //             // decoration: BoxDecoration(
            //             //   borderRadius: BorderRadius.circular(25),
            //             //   color: kPrimaryBlue,
            //             // ),
            //             child: Padding(
            //               padding: EdgeInsets.all(Get.width / 30),
            //               child: Center(
            //                 child: Text(
            //                   "Book another Cylinder",
            //                   style:
            //                       TextStyle(color: Colors.blue, fontSize: 20),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
                // Container(
                //   height: 40,
                //   width: 150,
                //   child: Container(
                //     child: GestureDetector(
                //       onTap: () {
                //         print(Get.previousRoute);
                //         controller.isLoading(false);
                //         Get.offAllNamed(AppPages.SEARCH);
                //         Get.snackbar("Message", "Payment is Unsuccessful.",
                //             backgroundColor: Colors.red,
                //             colorText: Colors.white,
                //             snackPosition: SnackPosition.BOTTOM);
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(25),
                //           color: kPrimaryBlue,
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.all(Get.width / 50),
                //           child: Center(
                //             child: Text(
                //               "Cancel",
                //               style:
                //                   TextStyle(color: kWhiteColor, fontSize: 20),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              // ],
            // ),
          );
        });
  }
}

       // return Scaffold(
          //   appBar: AppBar(
          //     title: Text("PayStack Payment"),
          //     leading: IconButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         icon: Icon(Icons.close)),
          //   ),
          //   body: controller.isLoading.value
          //       ? CircularProgressIndicator()
          //       : WebViewWidget(
          //           controller: controller.paymentwebviewController),
          // );