import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/image_picker.dart';
import '../../controllers/profile_controller.dart';
import '../../../../utils/styles/styles.dart';
import '../../../widgets/submit_button.dart';

class EditImagePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    File? image;
    File? imageFile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Image'.tr,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: Text(
                "Upload a photo of yourself ".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: GestureDetector(
                onTap: () async {
                  await ImagePickerDialog().pickGalleryImages(
                    maxImage: 10,
                    context: Get.context!,
                    onGet: (value) {
                      image = File(value.firstOrNull?.path ?? "");
                      imageFile = File(value.firstOrNull?.path ?? "");
                    },
                  );
                  controller.update();
                },
                child: GetBuilder<ProfileController>(
                  builder: (_) {
                    if (image != null) {
                      return CircleAvatar(
                        radius: 74,
                        backgroundColor: Styles.primaryColor,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(
                            imageFile!,
                          ),
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 73,
                        backgroundColor: Styles.primaryColor,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(
                            'assets/images/user.png',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: submitButton(
              onTap: () {
                if (imageFile == null) return;
                controller.updateProfilePic(imageFile!);
              },
              text: 'Update'.tr,
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.only(top: 40),
          //     child: Align(
          //         alignment: Alignment.bottomCenter,
          //         child: SizedBox(
          //           width: 330,
          //           height: 50,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               if (imageFile == null) return;
          //               controller.updateProfilePic(imageFile!);
          //             },
          //             child: Text(
          //               'Update'.tr,
          //               style: TextStyle(fontSize: 15),
          //             ),
          //           ),
          //         )))
        ],
      ),
    );
  }
}
