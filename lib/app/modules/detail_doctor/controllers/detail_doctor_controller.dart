import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../models/doctor_model.dart';
import '../../../models/review_model.dart';
import '../../../service/doctor_service.dart';
import '../../../service/payment_service.dart';
import '../../../service/review_service.dart';
import '../../../service/user_service.dart';

class DetailDoctorController extends GetxController with StateMixin<Doctor> {
  final count = 0.obs;
  Doctor selectedDoctor = Get.arguments;
  List<ReviewModel> listReview = [];
  PaymentService paymentService = Get.find();
  UserService userService = Get.find();
  @override
  void onInit() {
    super.onInit();
    ReviewService().getDoctorReview(doctor: selectedDoctor).then((value) {
      listReview = value;
      change(selectedDoctor, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void toChatDoctor() async {
    String doctorUserId = await DoctorService().getUserId(selectedDoctor);
    if (doctorUserId.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Teacher no longer exist'.tr,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
      return;
    }
    final otherUser = types.User(
      id: doctorUserId,
      firstName: selectedDoctor.doctorName,
      imageUrl: selectedDoctor.doctorPicture,
    );

    Room room = await FirebaseChatCore.instance.createRoom(otherUser);
    Get.toNamed('/chat', arguments: [room, selectedDoctor]);
  }

  // void makePayment(num count) async {
  //   var clientSecret =
  //       await paymentService.getClientSecret('', userService.getUserId());
  //   if (clientSecret.isEmpty) return;
  //   bool isSuccess =
  //       await Get.toNamed(Routes.PAYMENT, arguments: {"count": count});
  //   if (isSuccess) {
  //     // Get.offNamed('/payment-success', arguments: selectedTimeSlot);
  //   }
  // }
}
