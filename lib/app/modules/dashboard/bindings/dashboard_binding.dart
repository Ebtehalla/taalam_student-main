import 'package:get/get.dart';
import '../../../service/auth_service.dart';
import '../../../service/notification_service.dart';
import '../../../service/user_service.dart';
import '../../Posts/controllers/posts_controller.dart';
import '../../appointment/controllers/appointment_controller.dart';
import '../../doctor_category/controllers/doctor_category_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/dashboard_controller.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());

    Get.put(AuthService());
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
