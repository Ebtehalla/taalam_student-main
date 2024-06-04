// import 'package:get/get.dart';
// import '../../../service/videocall_service.dart';

// import '../controllers/video_call_controller.dart';

// class VideoCallBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<VideoCallController>(
//       () => VideoCallController(),
//     );
//     Get.put(VideoCallService());
//   }
// }
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/video_call/controllers/video_call_controller.dart';

class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(() => VideoCallController());
  }
}
