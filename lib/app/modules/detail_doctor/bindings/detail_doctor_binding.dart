import 'package:get/get.dart';

import '../../../service/doctor_service.dart';
import '../../../service/payment_service.dart';
import '../controllers/detail_doctor_controller.dart';

class DetailDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDoctorController>(
      () => DetailDoctorController(),
    );
    Get.lazyPut<DoctorService>(
      () => DoctorService(),
    );
    Get.lazyPut<PaymentService>(
      () => PaymentService(),
    );
  }
}
