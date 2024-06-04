import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../models/time_slot_model.dart';
import '../../../routes/app_pages.dart';
import '../../../service/order_service.dart';
import '../../../service/problem_service.dart';

class ConsultationConfirmController extends GetxController {
  TimeSlot timeSlot = Get.arguments;
  var problemVisible = false.obs;

  @override
  void onClose() {}

  sendProblem(String problem) {
    EasyLoading.show();
    ProblemService().sendProblem(problem, timeSlot).then((value) {
      Get.back();
      Get.defaultDialog(
          title: 'Info'.tr,
          onConfirm: () => Get.back(),
          middleText: 'Payment for '.tr +
              timeSlot.doctor!.doctorName! +
              ' will be delayed until the problem is resolved'.tr);
      EasyLoading.dismiss();
    });
  }

  confirmConsultation() async {
    try {
      EasyLoading.show();
      await OrderService().confirmOrder(timeSlot);
      EasyLoading.dismiss();
      Get.offNamed(Routes.REVIEW, arguments: timeSlot);
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
