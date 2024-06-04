import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../service/posts_services.dart';
import '../../../service/user_service.dart';
import '../../widgets/image_picker.dart';

class PostsController extends GetxController {
  UserService userService = Get.find();
  late Future<QuerySnapshot<Map<String, dynamic>>> getUserAllPosts;
  String? uid;
  List<PostModel> posts = [];
  ScrollController scrollController = ScrollController();
  User? user;
  @override
  void onReady() {
    getUserAllPosts = UserService().getUserAllPosts(uid ?? "");
    user = userService.currentUser;
    uid = user?.uid ?? "";
    print(uid);
    super.onReady();
  }

  @override
  void onInit() {
    postEditingController = TextEditingController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("end");
      }
    });
    super.onInit();
  }

  TextEditingController postEditingController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  GlobalKey<FormState> addPostKey = GlobalKey<FormState>();
  Rx<File> image = Rx<File>(File(""));
  RxString imageUrl = ''.obs;
  void pickPostImages() async {
    await ImagePickerDialog().pickGalleryImages(
      maxImage: 10,
      context: Get.context!,
      onGet: (value) {
        image.value = File(value.firstOrNull?.path ?? "");
        imageUrl.value = value.firstOrNull?.path ?? "";
      },
    );
    update();
  }

  Future<bool> uploadPost() async {
    EasyLoading.show();
    DateTime now = DateTime.now();
    var datestamp = DateFormat("yyyyMMdd'T'HHmmss");
    String currentdate = datestamp.format(now);
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('postImages')
        .child(uid ?? "")
        .child(currentdate);
    if (image.value.path.isNotEmpty) {
      await ref.putFile(image.value).then((value) async {
        await value.ref.getDownloadURL().then((value) {
          imageUrl.value = value;
        });
      });
    }
    EasyLoading.dismiss();
    return imageUrl.value == "";
  }

  Future addPost() async {
    var uploud = await uploadPost();
    if (uploud) {
      var res = await PostService.addPost(
        PostModel(
          title: postEditingController.text,
          description: postEditingController.text,
          imageUrl: imageUrl.value,
          isServiceProvider: false,
          maxPrice: num.parse(maxPriceController.text),
          minPrice: num.parse(minPriceController.text),
          uid: uid ?? "",
          user: UserModel(
            displayName: user?.displayName,
            photoUrl: user?.photoURL ?? "",
            userId: uid ?? "",
          ),
        ),
        uid ?? "",
      );
      if (res) {
        Get.toNamed(Routes.DASHBOARD);
        Get.forceAppUpdate();
      } else {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
    }
  }
}
