import 'dart:io';

import 'package:bettergas_assignment/app/components/elevatedbutton.dart';
import 'package:bettergas_assignment/app/components/show_loader.dart';
import 'package:bettergas_assignment/app/data/local/my_shared_pref.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (c) {
          return c.isLoading
              ? Scaffold(
                  body: ShowLoader(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: kPrimaryBlue,
                    iconTheme: IconThemeData(color: kWhiteColor),
                    leading: IconButton(
                        onPressed: () {
                          Get.offAllNamed(AppPages.SEARCH);
                        },
                        icon: Icon(Icons.arrow_back)),
                    title: Text(
                      "My Profile",
                      style: TextStyle(fontSize: 20, color: kWhiteColor),
                    ),
                    actions: [
                      c.isEditing!
                          ? Container()
                          : InkWell(
                              onTap: () {
                                c.isEditing = !c.isEditing!;
                                c.update();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            )
                    ],
                  ),
                  body: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text(
                              'Name',
                              style: TextStyle(
                                color: kPrimaryBlue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: c.isEditing!
                                ? TextField(
                                    controller: c.nameCtrl,
                                    decoration: const InputDecoration(
                                      hintText: "Enter name",
                                    ),
                                    readOnly: false,
                                  )
                                : Text(
                                    c.isProperString(c.userName)!
                                        ? c.userName!
                                        : 'N/A',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text(
                              'Phone',
                              style: TextStyle(
                                color: kPrimaryBlue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: c.isEditing!
                                ? TextField(
                                    controller: c.phCtrl,
                                    inputFormatters: [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.digitsOnly ],
                                    decoration: const InputDecoration(
                                      hintText: "Enter phone",
                                    ),
                                  )
                                : Text(
                                    c.isProperString(c.userPhone)!
                                        ? c.userPhone!
                                        : "N/A" /*'+91987654321'*/,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text(
                              'Email',
                              style: TextStyle(
                                color: kPrimaryBlue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: c.isEditing!
                                ? TextField(
                                    controller: c.emCtrl,
                                    decoration: const InputDecoration(
                                      hintText: "Enter email",
                                    ),
                                    readOnly: true,
                                  )
                                : Text(
                                    c.isProperString(c.userEmail)!
                                        ? c.userEmail!
                                        : 'N/A',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text(
                              'Address',
                              style: TextStyle(
                                color: kPrimaryBlue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: c.isEditing!
                                ? TextField(
                                    controller: c.addressCtrl,
                                    decoration: const InputDecoration(
                                      hintText: "Enter address",
                                    ),
                                  )
                                : Text(
                                    c.isProperString(c.useraddress)!
                                        ? c.useraddress!
                                        : "N/A" /*'+91987654321'*/,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                          const Divider(),
                          // const ListTile(
                          //   title: Text(
                          //     'Transaction History',
                          //     style: TextStyle(
                          //       color: Colors.deepOrange,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          //   trailing: Icon(Icons.arrow_forward_ios_rounded,
                          //       color: Colors.black),
                          // ),
                          // const Divider(),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            c.isEditing == true
                                ? SizedBox(
                                    width: double.infinity,
                                    child: c.btnLoader
                                        ? Container(
                                            height: 50,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              ),
                                            ))
                                        : c.btnLoader1
                                            ? Container(
                                                //height: 50,
                                                child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.red,
                                                ),
                                              ))
                                            : MyButton(
                                                ontap: () async {
                                                  c.showLoader1();
                                                  await c.editProfileDetails();
                                                  c.hideLoader1();
                                                },
                                                text: 'Save',
                                              ),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    child: c.btnLoader
                                        ? Container(
                                            height: 50,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              ),
                                            ))
                                        : MyButton(
                                            text: "Logout",
                                            ontap: () async {
                                              c.showLoader();
                                              MySharedPref.clearSession();
                                              Get.offAllNamed(AppPages.SIGNIN);
                                              c.hideLoader();
                                            }),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            c.isEditing == true
                                ? Container()
                                : SizedBox(
                                    width: double.infinity,
                                    child: c.btnLoader
                                        ? Container(
                                            height: 50,
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.red,
                                              ),
                                            ))
                                        : MyButton(
                                            text: "Edit Password",
                                            ontap: () async {
                                              c.showLoader();
                                              // await c.logout();
                                              Get.toNamed(
                                                  AppPages.CHANGE_PASSWORD);
                                              c.hideLoader();
                                            }),
                                  ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // c.isLoading == true
                            //     ? Center(
                            //         child: CircularProgressIndicator(
                            //           color: Colors.red,
                            //         ),
                            //       )
                            //     : MyButton(
                            //         text: "Delete Account",
                            //         ontap: () {
                            //           Get.dialog(Center(
                            //             child: Wrap(
                            //               children: [
                            //                 Material(
                            //                   type: MaterialType.transparency,
                            //                   child: Container(
                            //                     padding: EdgeInsets.symmetric(
                            //                         horizontal: 35, vertical: 24),
                            //                     margin:
                            //                         EdgeInsets.symmetric(horizontal: 25),
                            //                     decoration: BoxDecoration(
                            //                         borderRadius:
                            //                             BorderRadius.circular(16),
                            //                         color: Colors.white),
                            //                     child: Column(
                            //                       mainAxisSize: MainAxisSize.min,
                            //                       children: [
                            //                         Row(
                            //                           children: [
                            //                             Expanded(
                            //                                 child: Text(
                            //                                     "Once the delete request is initiated, you would be no longer to access your account. Your data will be removed from servers in 14 days from the date of deletion request"))
                            //                           ],
                            //                         ),
                            //                         SizedBox(
                            //                           height: 15,
                            //                         ),
                            //                         Row(
                            //                           mainAxisAlignment:
                            //                               MainAxisAlignment.spaceAround,
                            //                           children: [
                            //                             MyButton(
                            //                               text: "Delete",
                            //                               ontap: () {
                            //                                 c.deleteProfile();
                            //                               },
                            //                             ),
                            //                             MyButton(
                            //                               text: "Back",
                            //                               ontap: () {
                            //                                 Get.back();
                            //                               },
                            //                             )
                            //                           ],
                            //                         )
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ));
                            //         })
                          ],
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}
