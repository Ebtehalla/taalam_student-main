import 'package:get/get.dart';

import '../../../service/user_service.dart';
import '../controllers/posts_controller.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsController>(() => PostsController());
    Get.put(UserService());
  }
}
