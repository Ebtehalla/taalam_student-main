import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../../../service/user_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(AuthService());
    Get.put(UserService());
  }
}
