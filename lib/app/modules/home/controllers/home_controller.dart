import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../../service/auth_service.dart';
import '../../../service/carousel_service.dart';
import '../../../service/user_service.dart';

class HomeController extends GetxController {
  final caoruselIndex = 0.obs;
  get getcaoruselIndex => caoruselIndex.value;
  AuthService authService = Get.find();
  UserService userService = Get.find();
  var userPicture = ''.obs;
  List<String?> listImageCarousel = [];

  @override
  void onInit() async {
    super.onInit();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    userPicture.value = userService.getProfilePicture()!;
    listImageCarousel = await CarouselService().getListCarouselUrl();
    print('jumlah image carousel : ${listImageCarousel.length}');
    update();
  }

  @override
  void onClose() {}
  void carouselChange(int index) {
    caoruselIndex.value = index;
  }

  void logout() async {
    authService.logout().then((value) => Get.toNamed('/login'));
  }

  void toDoctorCategory() {
    Get.find<DashboardController>().selectedIndex = 1;
  }

  void toTopRatedDoctor() {
    Get.toNamed('/top-rated-doctor');
  }

  void toSearchDoctor() {
    Get.toNamed('/search-doctor');
  }
}
