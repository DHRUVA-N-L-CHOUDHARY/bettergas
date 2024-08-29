import 'package:bettergas_assignment/app/data/local/my_shared_pref.dart';
import 'package:bettergas_assignment/app/routes/app_pages.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../utils/common_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              MySharedPref.getEmail() == "guest@email.com"
                  ? print("---------")
                  : Get.toNamed(AppPages.SEARCH);
              MySharedPref.getEmail() == "guest@email.com"
                  ? print("---------")
                  : Get.toNamed(AppPages.SEARCH);
            },
            child: ListTile(
              minVerticalPadding: 30,
              title: Text(
                MySharedPref.getName().capitalize ?? "",
                style: TextStyle(color: kWhiteColor, fontSize: 25),
              ),
              subtitle: MySharedPref.getEmail() == "guest@email.com"
                  ? Container(
                      height: 10,
                      width: 10,
                    )
                  : Text(
                      MySharedPref.getEmail(),
                      style: TextStyle(color: kWhiteColor, fontSize: 16),
                    ),
              // currentAccountPicture: Container(
              //   width: 120,
              //   height: 120,
              //   padding: const EdgeInsets.all(2),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(60)),
              //   //backgroundColor: Colors.white70,
              //   //minRadius: 60.0,
              //   child: Container(
              //     width: 120,
              //     height: 120,
              //     decoration: BoxDecoration(
              //         //  color: Colors.white70,
              //         borderRadius: BorderRadius.circular(60)),
              //     child: ClipOval(
              //         child: Image.asset(
              //       "assets/user.png",
              //       width: 90,
              //       fit: BoxFit.cover,
              //       errorBuilder: (BuildContext context, Object exception,
              //           dynamic stackTrace) {
              //         return Container(
              //             color: Colors.red.withOpacity(0.1),
              //             width: 90,
              //             height: 90,
              //             child: Center(
              //               child: Icon(
              //                 Icons.add_a_photo_outlined,
              //                 color: Colors.red.withOpacity(0.3),
              //                 size: 28,
              //               ),
              //             ));
              //       },
              //       height: 90,
              //     )),
              //   ),
              // ),
              // decoration: const BoxDecoration(
              tileColor: kPrimaryBlue,
              // ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.gas_meter),
            title: Text('Buy Gas'),
            onTap: () => {Navigator.of(context).pop()},
          ),
           ListTile(
            leading: Icon(Icons.location_on),
            title: Text('All locations'),
            onTap: () => {Get.toNamed(AppPages.ALLLOCATIONS)},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {Get.toNamed(AppPages.PROFILE)},
          ),
         
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Order History'),
            onTap: () => {Get.toNamed(AppPages.ORDER_HISTORY)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Get.offAllNamed(AppPages.SIGNIN);
              MySharedPref.clearSession();
            },
          ),
          ExpansionTile(
            title: Text(
              "Settings & Support",
              style: TextStyle(color: kSecondaryBlue),
            ),
            initiallyExpanded: true,
            children: [
              // ListTile(
              //   minLeadingWidth: 1,
              //   dense: true,
              //   leading: Icon(Icons.support_agent_sharp),
              //   title: Text('Contact Us'),
              //   onTap: () {
              //     launchUrlString("https://bettergas.com/contact-us/",
              //         mode: LaunchMode.externalApplication);
              //   },
              // ),
              // const Divider(),
              ListTile(
                minLeadingWidth: 1,
                dense: true,
                leading: Icon(Icons.phone_forwarded),
                title: Text('Call Us'),
                onTap: () {
                  makePhoneCall("+234 905 960 9999");
                },
              ),
              const Divider(),
              ListTile(
                minLeadingWidth: 1,
                dense: true,
                leading: Icon(Icons.chat),
                title: Text('Chat Us'),
                onTap: () {
                  launchUrlString("https://wa.me/0905 960 9999",
                      mode: LaunchMode.externalApplication);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/icons/Logo.png",
              fit: BoxFit.contain,
              width: 120,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      launch(('https://www.facebook.com/people/Better-Gas-Energy-Ltd/100089749420769/?mibextid=ZbWKwL'));
                    },
                    child: Image.asset(
                      "assets/icons/facebook.png",
                      height: 30,
                      color: kPrimaryBlue,
                    )),
                GestureDetector(
                    onTap: () {
                      launchUrl(
                          Uri.parse('https://www.instagram.com/bettergasng/'));
                    },
                    child: Image.asset(
                      "assets/icons/instagram.png",
                      height: 30,
                    )),
                GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://www.linkedin.com/company/better-gas-ng/'));
                    },
                    child: Image.asset(
                      "assets/icons/linkedIn.png",
                      height: 30,
                    )),
                GestureDetector(
                    onTap: () {
                      launchUrl(
                          Uri.parse('https://twitter.com/i/flow/login?redirect_after_login=%2Fbettergasng'));
                    },
                    child: Image.asset(
                      "assets/icons/twitter.png",
                      height: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
