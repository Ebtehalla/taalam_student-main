import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'widgets/profile_button.dart';
import '../../../utils/icons/MyStudent_icons.dart';

import '../../../utils/styles/styles.dart';
import '../controllers/profile_controller.dart';
import 'widgets/display_image_widget.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Profile'.tr,
          style: Styles.appBarTextStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: Brightness.dark),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              GestureDetector(
                  onTap: () {},
                  child: DisplayImage(
                    imagePath: controller.profilePic.value,
                    onPressed: () {
                      controller.toEditImage();
                    },
                  )),
              SizedBox(height: 50),
              Column(
                children: [
                  ProfileButton(
                    icon: MyStudent.profile,
                    text: controller.username.value,
                    onTap: () {},
                    hideArrowIcon: true,
                  ),
                  ProfileButton(
                    icon: MyStudent.sms,
                    text: controller.email.value,
                    onTap: () {
                      controller.toUpdateEmail();
                    },
                  ),
                  ProfileButton(
                    icon: MyStudent.lock,
                    text: 'Change Password'.tr,
                    onTap: () {
                      controller.toChangePassword();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProfileButton(
                    onTap: () {
                      controller.logout();
                    },
                    icon: MyStudent.undo,
                    text: 'Logout'.tr,
                    hideArrowIcon: true,
                  ),

                  //uncomment if you wanto test something
                  // ElevatedButton(
                  //   onPressed: () {
                  //     controller.testButton();
                  //     //LocalizationService().changeLocale('France');
                  //   },
                  //   child: Text('test button'),
                  // )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => editPage);
                      },
                      child: Text(
                        getValue,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
