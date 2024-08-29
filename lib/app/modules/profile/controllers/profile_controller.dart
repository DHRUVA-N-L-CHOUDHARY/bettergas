// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'dart:convert';
import 'dart:io';

import 'package:bettergas_assignment/app/components/snackBar.dart';
import 'package:bettergas_assignment/app/data/models/customer_model.dart';
import 'package:bettergas_assignment/app/data/remote/api_service.dart';
import 'package:bettergas_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  String? userName, userImage, userEmail, userPhone, userId, token, useraddress;
  bool? isEditing = false;
  XFile? selectedAvatar;
  File? croppedFile;
  String? userPropic;
  bool? isEnabled = false;

  bool? isUploading = false;
  bool isLoading = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emCtrl = TextEditingController();
  TextEditingController phCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  bool btnLoader = false;

  void showLoader() {
    debugPrint("ShowLoader");
    btnLoader = true;
    update();
  }

  void hideLoader() {
    debugPrint("hideLoader");
    btnLoader = false;
    update();
  }

  bool btnLoader1 = false;

  void showLoader1() {
    debugPrint("ShowLoader");
    btnLoader1 = true;
    update();
  }

  void hideLoader1() {
    debugPrint("hideLoader");
    btnLoader1 = false;
    update();
  }

  Future<void> init() async {
    userName = MySharedPref.getName();
    userEmail = MySharedPref.getEmail();
    userPhone = MySharedPref.getPhone();
    userId = MySharedPref.getUserId();
    userImage = MySharedPref.getAvatar();
    useraddress = MySharedPref.getAddress();
    token = MySharedPref.getToken();
    nameCtrl.text = isProperString(userName)! ? userName! : "";
    emCtrl.text = isProperString(userEmail)! ? userEmail! : "";
    phCtrl.text = isProperString(userPhone)! ? userPhone! : "";
    addressCtrl.text = isProperString(useraddress)! ? useraddress! : "";
    update();
  }

  bool? isProperString(String? s) {
    if (s != null && s.trim().isNotEmpty && s.trim() != "null") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> editProfileDetails() async {
    try {
      isLoading = true;
      update();
      if (nameCtrl.text.trim().isEmpty ||
          phCtrl.text.trim().isEmpty ||
          emCtrl.text.trim().isEmpty) {
        showSnackbar(
            "Required Fields are Missing", "Items are mandatory");
        isLoading = false;
        update();
        return;
      }
      if (phCtrl.text.length != 11) {
        showSnackbar("Phone Number", "Enter correct phone number");
        isLoading = false;
        update();
        return;
      }
      Map<String, dynamic> data = {
        "email": emCtrl.text,
        "first_name": nameCtrl.text,
        "billing": {
          "first_name": nameCtrl.text,
          "email": emCtrl.text,
          "phone": phCtrl.text,
          "address_1": addressCtrl.text
        },
        "shipping": {
          "first_name": nameCtrl.text,
          "address_1": addressCtrl.text,
        }
      };
      print(data);
      print(MySharedPref.getUserId());
      dynamic res = await ApiService().updateUserDetails(
          data, userId ?? MySharedPref.getUserId().toString());
      if (res.statusCode == 200) {
        Map<String, dynamic> updateResponse = jsonDecode(res.body);
        print(updateResponse);
        CustomerModel customerModel =
            await CustomerModel.fromJson(updateResponse);
        if (customerModel.email!.isNotEmpty &&
            customerModel.firstName!.isNotEmpty &&
            customerModel.billing!.phone!.isNotEmpty) {
          print(customerModel);
          MySharedPref.setEmail(customerModel.email.toString());
          MySharedPref.setName(customerModel.firstName.toString());
          MySharedPref.setPhone(customerModel.billing!.phone.toString());
          MySharedPref.setAddress(customerModel.shipping!.address1.toString());
          isLoading = false;
          update();
          Get.snackbar("Successfull", "Profile updated successfully",
              backgroundColor: kPrimaryBlue,
              colorText: kWhiteColor,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          isLoading = false;
          update();
          Get.snackbar("Error", "Couldn't Update your Profile Details",
              backgroundColor: Colors.red,
              colorText: kWhiteColor,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        isLoading = false;
        update();
        Get.snackbar("Error", "Couldn't Update your Profile Details",
            backgroundColor: Colors.red,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Error", "Couldnt Update your Profile Details",
          backgroundColor: Colors.red,
          colorText: kWhiteColor,
          snackPosition: SnackPosition.BOTTOM);
      throw e;
    }
  }

  Future<void> deleteProfile() async {
    isLoading = true;
    update();
    Map<String, dynamic> res = await ApiService().deleteCustomer();
    if (res["id"] != null) {
      showSuccessfulSnackbar("Account Deleted Successfully");
      MySharedPref.clearSession();
      Get.offAllNamed(AppPages.SIGNUP);
    } else {
      showSnackbar(res["message"], "");
    }
  }
}

// addPropicApi2() async {
//   var headers = {
//     'Content-Type': 'multipart/form-data;',
//     'Authorization': 'Bearer $token'
//   };
//   var request = http.MultipartRequest(
//       'PUT', Uri.parse('${ApiInterface.baseUrl}/Userapi/updateProfile'));
//   request.fields.addAll({
//     'userid': userId!,
//     'token': token!,
//     'name': nameCtrl.text.trim(),
//     'phone': phCtrl.text.trim(),
//   });
//   if (croppedFile != null) {
//     request.files
//         .add(await http.MultipartFile.fromPath('image', croppedFile!.path));
//   }
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     String? res = await response.stream.bytesToString();
//     ProfileResponse? resp = null;
//     if (response.statusCode == 200) {
//       debugPrint("IMAGE SUCCESS $res");
//       //ApiService().returnResponse(response.data);
//       resp = profileResponseFromJson(res);
//       //userPropic = res!.data!.s3FileName!.toString();

//       MySharedPref.setUserId(resp!.data!.id.toString());
//       MySharedPref.setName(resp.data!.name.toString());
//       MySharedPref.setToken(resp.data!.token.toString());
//       MySharedPref.setEmail(resp.data!.email.toString());
//       MySharedPref.setPhone(resp.data!.phone.toString());
//       MySharedPref.setAvatar(resp.data!.image.toString());
//       isEditing = false;
//       isEnabled = true;
//       init();
//       // await notificationApi();
//       isUploading = false;
//       //isNotUploading = true;
//       homecontroller.updateImageVariable();
//     } else {
//       isUploading = false;
//       Get.snackbar("Image Upload Failed Response Code ${response.statusCode}",
//           "Error");
//     }
//     update();
//   } else {
//     print(response.reasonPhrase);
//     isUploading = false;
//     Get.snackbar("Image Upload Failed Response Code ${response.reasonPhrase}",
//         "Error");
//     update();
//   }
// }

// addPropicApi() async {
//   isUploading = true;
//   update();
//   debugPrint("MAKING IMAGE REQUEST");
//   // String? userId = await SecuredStorage.readStringValue(Keys.userId);
//   //var auth = await SharedPref.getString(SharedPref.authToken);
//   try {
//     ///[1] CREATING INSTANCE
//     var dioRequest = dio.Dio();
//     dioRequest.options.baseUrl =
//         ApiInterface.baseUrl + Endpoints.userApiUpdateProfile;

//     //[2] ADDING TOKEN
//     dioRequest.options.headers = {
//       //"Authorization": "Bearer " + auth!,
//       //'Content-Type': 'application/x-www-form-urlencoded'
//       // 'Content-Type': 'multipart/form-data',
//       //'enctype': 'multipart/form-data'
//       'Cookie':
//           '__88ok4w0s48kwosg08404k0sswsowwg08ccc0c0s0=651fb6f5a64f8009c94b84cf4bc56535b42a677f; language=english'
//     };

//     //[3] ADDING EXTRA INFO
//     var formData = dio.FormData.fromMap({
//       'userid': userId,
//       'token': token,
//       'name': nameCtrl.text.trim(),
//       'phone': phCtrl.text.trim(),
//     });

//     //[4] ADD IMAGE TO UPLOAD
//     if (croppedFile != null) {
//       var file = await dio.MultipartFile.fromFile(croppedFile!.path,
//           filename: "profile_pic_${DateTime.now().toIso8601String()}",
//           contentType: MediaType(
//             "image",
//             "profile_pic_${DateTime.now().toIso8601String()}",
//           ));

//       formData.files.add(MapEntry('image', file));
//     }

//     //[5] SEND TO SERVER
//     if (croppedFile != null) {
//       var response = await dioRequest.post(
//         ApiInterface.baseUrl + Endpoints.userApiUpdateProfile,
//         data: formData,
//       );
//       ProfileResponse? resp = null;
//       if (response.statusCode == 200) {
//         debugPrint("IMAGE SUCCESS ${response.data}");
//         //ApiService().returnResponse(response.data);
//         resp = ProfileResponse.fromJson(response.data);
//         //userPropic = res!.data!.s3FileName!.toString();

//         MySharedPref.setUserId(resp.data!.id.toString());
//         MySharedPref.setName(resp.data!.name.toString());
//         MySharedPref.setToken(resp.data!.token.toString());
//         MySharedPref.setEmail(resp.data!.email.toString());
//         MySharedPref.setPhone(resp.data!.phone.toString());
//         MySharedPref.setAvatar(resp.data!.image.toString());
//         isEditing = false;
//         isEnabled = true;

//         // await notificationApi();
//         isUploading = false;
//         //isNotUploading = true;
//       } else {
//         isUploading = false;
//         Get.snackbar(
//             "Image Upload Failed Response Code ${response.statusCode}",
//             "Error");
//       }
//       update();
//       //Navigator.of(context).pop();
//     } else {
//       //Navigator.of(context).pop();
//       // isNotUploading = true;
//       isUploading = false;
//       update();
//     }
//   } on dio.DioError catch (err) {
//     debugPrint("EROR111 ${err.message}");
//     isUploading = false;
//     Get.snackbar(err.message ?? "", "Error");
//     if (err.response == null) {
//       debugPrint("Error 1");
//       //isNotUploading = true;
//     }
//     if (err.response != null && err.response!.statusCode == 413) {
//       debugPrint("Error 413");
//       //isNotUploading = true;
//       //update();
//     }
//     if (err.response != null && err.response!.statusCode == 400) {
//       debugPrint("Error 400");
//       //isNotUploading = true;
//       //update();
//     }
//     update();
//   }
// }

Future<void> logout() async {
  Get.offAllNamed(AppPages.SIGNIN);
  MySharedPref.clearSession();
}

  // void pickImage(ImageSource source) async {
  //   selectedAvatar = await ImagePicker().pickImage(source: source);
  //   if (selectedAvatar != null) {
  //     CroppedFile? cf = await ImageCropper().cropImage(
  //       sourcePath: selectedAvatar!.path,
  //       cropStyle: CropStyle.circle,
  //       compressFormat: ImageCompressFormat.jpg,
  //       compressQuality: 20,
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: Colors.red,
  //           toolbarWidgetColor: Colors.white,
  //         ),
  //         IOSUiSettings(
  //           title: 'Crop Image',
  //         ),
  //       ],
  //     );
  //     if (cf != null) {
  //       croppedFile = File(cf.path);
  //     }
  //   }

  //   update();
  // }