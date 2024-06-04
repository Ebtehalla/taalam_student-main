// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/video_call_controller.dart';

// class VideoCallView extends GetView<VideoCallController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GetBuilder<VideoCallController>(
//           builder: (_) {
//             return Stack(
//               children: [
//                 Center(
//                   child: _remoteVideo(controller),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     width: 100,
//                     height: 150,
//                     child: Center(
//                       child: controller.localUserJoined
//                           ? _localPreview(controller)
//                           : CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   child: Container(
//                     width: Get.width,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         FloatingActionButton(
//                           onPressed: controller.toggleLotcalAudioMuted,
//                           child: controller.localAudioMute == false
//                               ? Icon(Icons.mic)
//                               : Icon(Icons.mic_off),
//                           heroTag: 'micOff',
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         FloatingActionButton(
//                           onPressed: controller.switchCamera,
//                           child: Icon(Icons.switch_camera),
//                           heroTag: 'cameraSwitch',
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         FloatingActionButton(
//                           onPressed: () {
//                             controller.endMeeting();
//                           },
//                           child: Icon(Icons.call_end),
//                           backgroundColor: Colors.red,
//                           heroTag: 'endMeeting',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

// // Display local video preview
//   Widget _localPreview(VideoCallController controller) {
//     if (controller.localUserJoined) {
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: controller.engine,
//           canvas: VideoCanvas(
//             uid: 0,
//           ),
//         ),
//       );
//     } else {
//       return const Text(
//         'join a channel',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

// // Display remote user's video
//   Widget _remoteVideo(VideoCallController controller) {
//     if (controller.remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: controller.engine,
//           canvas: VideoCanvas(uid: controller.remoteUid),
//           connection: RtcConnection(channelId: controller.room),
//         ),
//       );
//     } else {
//       String msg = '';
//       if (controller.localUserJoined) msg = 'Waiting for a remote user to join';
//       return Text(
//         msg,
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:hallo_doctor_client/app/modules/video_call/controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Demo')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.isSubscribed.value) {
          return ListView.builder(
            itemCount: controller.zoomLinks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Lesson ${index + 1}'),
                subtitle: Text(controller.zoomLinks[index]),
              );
            },
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: controller.videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: controller
                              .videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(controller.videoPlayerController),
                        )
                      : CircularProgressIndicator(),
                ),
              ),
              ElevatedButton(
                onPressed: controller.handlePayment,
                child: Text('Subscribe for ${controller.coursePrice} USD'),
              ),
            ],
          );
        }
      }),
    );
  }
}
