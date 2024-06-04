import 'package:get/get.dart';

import '../../../models/doctor_category_model.dart';
import '../../../models/doctor_model.dart';
import '../../../service/doctor_service.dart';

class ListDoctorController extends GetxController
    with StateMixin<List<Doctor>> {
  DoctorCategory doctorCategory = Get.arguments;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('doctor category Name : ${doctorCategory.categoryName!}');
    DoctorService().getListDoctorByCategory(doctorCategory).then((value) {
      if (value.isEmpty) return change([], status: RxStatus.empty());
      print('doctor : $value');
      change(value, status: RxStatus.success());
    }).catchError((err) {
      change([], status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
