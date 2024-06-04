import 'package:get/get.dart';
import '../../../models/doctor_model.dart';
import '../../../service/doctor_service.dart';

class TopRatedDoctorController extends GetxController
    with StateMixin<List<Doctor>> {

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    DoctorService().getTopRatedDoctor().then((value) {
      change(value, status: RxStatus.success());
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
