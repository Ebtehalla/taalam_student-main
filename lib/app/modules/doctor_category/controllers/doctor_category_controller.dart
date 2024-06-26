import 'package:get/get.dart';

import '../../../models/doctor_category_model.dart';
import '../../../service/doctor_category_service.dart';

class DoctorCategoryController extends GetxController
    with StateMixin<List<DoctorCategory>> {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    DoctorCategoryService().getListDoctorCategory().then((value) {
      change(value, status: RxStatus.success());
    }).catchError((err) {
      print('error : $err');
      change([], status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
