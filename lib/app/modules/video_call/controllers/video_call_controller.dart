// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../models/time_slot_model.dart';
// import '../../../service/videocall_service.dart';
// import '../../../utils/environment.dart';

// class VideoCallController extends GetxController {
//   TimeSlot orderedTimeslot = Get.arguments[0]['timeSlot'];
//   String token = Get.arguments[0]['token'];
//   String room = Get.arguments[0]['room'];
//   int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
//   bool videoCallEstablished = false;
//   int? remoteUid;
//   late RtcEngine engine;
//   bool localAudioMute = false;
//   bool localUserJoined = false;
//   @override
//   void onInit() {
//     super.onInit();
//     initAgora();
//   }

//   Future endMeeting() async {
//     await VideoCallService().removeRoom(orderedTimeslot.timeSlotId!);
//     await engine.leaveChannel();
//     await engine.release();
//     Get.back();
//   }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();
//     engine = createAgoraRtcEngine();
//     //create the engine
//     await engine.initialize(RtcEngineContext(appId: Environment.agoraAppId));
//     await engine.enableVideo();
//     engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           print("local user ${connection.localUid} joined");
//           localUserJoined = true;
//           update();
//         },
//         onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//           print("remote user $uid joined");
//           remoteUid = uid;
//           update();
//         },
//         onUserOffline:
//             (RtcConnection connection, int uid, UserOfflineReasonType reason) {
//           print("remote user $uid left channel");
//           remoteUid = null;
//           endMeeting();
//           update();
//         },
//       ),
//     );
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     update();
//   }

//   @override
//   void onClose() {}

//   void hangUp() async {
//     Get.back();
//   }

//   Future switchCamera() async {
//     try {
//       await engine.switchCamera();
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   Future toggleLotcalAudioMuted() async {
//     try {
//       localAudioMute = !localAudioMute;
//       await engine.muteLocalAudioStream(localAudioMute);
//       update();
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCallController extends GetxController {
  var isLoading = true.obs;
  var isSubscribed = false.obs;
  late VideoPlayerController videoPlayerController;
  late String demoVideoUrl;
  late double coursePrice;
  var zoomLinks = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourseDetails();
  }

  void fetchCourseDetails() async {
    try {
      var courseDoc = await FirebaseFirestore.instance
          .collection('courses')
          .doc('courseId')
          .get();
      demoVideoUrl = courseDoc['demo_video_url'];
      coursePrice = courseDoc['price'];
      zoomLinks.value = List<String>.from(courseDoc['zoom_links']);

      videoPlayerController = VideoPlayerController.network(demoVideoUrl)
        ..initialize().then((_) {
          isLoading.value = false;
          videoPlayerController.play();
        });
    } catch (e) {
      print('Error fetching course details: $e');
    }
  }

  Future<void> handlePayment() async {
    // تنفيذ عملية الدفع هنا
    isSubscribed.value = true;
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
