import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../views/pages/change_password.dart';
import '../views/pages/edit_image_page.dart';
import '../views/pages/update_email_page.dart';
import '../../../service/auth_service.dart';
import '../../../service/user_service.dart';
import '../../../utils/styles/styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var username = ''.obs;
  var profilePic = ''.obs;
  var appVersion = ''.obs;
  var email = ''.obs;
  var newPassword = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  @override
  void onReady() {
    super.onReady();
    var user = userService.currentUser;
    print('user : $user');
    profilePic.value = userService.getProfilePicture()!;
    username.value = user!.displayName!;
    email.value = user.email!;
  }

  @override
  void onClose() {}

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      buttonColor: Styles.primaryColor,
      cancelTextColor: Colors.red,
      confirmTextColor: Styles.secondaryColor,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        authService.logout().then(
              (value) => Get.offAllNamed('/login'),
            );
      },
    );
  }

  toEditImage() {
    Get.to(() => EditImagePage());
  }

  toUpdateEmail() {
    Get.to(() => UpdateEmailPage());
  }

  toChangePassword() {
    Get.to(() => ChangePasswordPage());
  }

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    userService.updateProfilePic(filePath).then((updatedUrl) {
      profilePic.value = updatedUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          backgroundColor: Colors.white,
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void updateEmail(String email) async {
    // if (!(await checkGoogleLogin())) return;
    try {
      UserService().updateEmail(email).then((value) {
        Get.back();
        this.email.value = email;
        update();
      }).catchError((err) {
        Fluttertoast.showToast(
            msg: err.toString(),
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }).whenComplete(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    // if (!(await checkGoogleLogin())) return;

    try {
      await UserService().changePassword(currentPassword, newPassword);
      currentPassword = '';
      newPassword = '';
      Get.back();
      Fluttertoast.showToast(
          msg: 'Successfully change password'.tr,
          backgroundColor: Colors.white,
          textColor: Colors.black);
    } catch (err) {
      Fluttertoast.showToast(
          msg: err.toString(),
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
    EasyLoading.dismiss();
  }

//user for testing something
  Future testButton() async {
    try {
      // print('my uid : ' + UserService().currentUser!.uid);
      // Get.to(() => ListUser());
      await Future.delayed(Duration(seconds: 10));
      // notificationService.showCallNotification('amsyari', 'roomname', 'token');
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Future<bool> checkGoogleLogin() async {
  //   bool loginGoogle = await AuthService().checkIfGoogleLogin();
  //   print('is login google : ' + loginGoogle.toString());
  //   if (loginGoogle) {
  //     Fluttertoast.showToast(
  //         msg: 'your login method, it is not possible to change this data');
  //     return false;
  //   }
  //   return loginGoogle;
  // }
}
