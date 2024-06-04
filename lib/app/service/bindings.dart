import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';

import '../modules/Posts/controllers/posts_controller.dart';
import '../modules/appointment/controllers/appointment_controller.dart';
import '../modules/doctor_category/controllers/doctor_category_controller.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/profile/controllers/profile_controller.dart';
import 'auth_service.dart';
import 'notification_service.dart';
import 'user_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<NotificationService>(() => NotificationService());
    Get.lazyPut<UserService>(() => UserService());
    Get.put(HomeController());
    Get.put(DoctorCategoryController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<DoctorCategoryController>(() => DoctorCategoryController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<TimeSlotService>(() => TimeSlotService());
    Get.lazyPut<PostsController>(() => PostsController());
  }
}
