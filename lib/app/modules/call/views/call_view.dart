import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/styles/styles.dart';
import '../controllers/call_controller.dart';

class CallView extends GetView<CallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CallController>(
          builder: (controller) {
            return Stack(
              children: [
                Center(
                  child: RemoteVideo(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: controller.localUserJoined
                          ? LocalPreviewVideo()
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.localUserJoined
                              ? () => controller.shareScreen()
                              : null,
                          child: Icon(Icons.screen_share_rounded),
                          heroTag: 'shareScreen',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.toggleLotcalAudioMuted,
                          child: controller.localAudioMute == false
                              ? Icon(Icons.mic)
                              : Icon(Icons.mic_off),
                          heroTag: 'micOff',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.switchCamera,
                          child: Icon(Icons.switch_camera),
                          heroTag: 'cameraSwitch',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            controller.endMeeting();
                          },
                          child: Icon(Icons.call_end),
                          backgroundColor: Colors.red,
                          heroTag: 'endMeeting',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Display local video preview
class LocalPreviewVideo extends StatelessWidget {
  const LocalPreviewVideo({super.key});
  @override
  Widget build(BuildContext context) {
    // Display local video or screen sharing preview
    return GetBuilder<CallController>(builder: (controller) {
      if (controller.localUserJoined) {
        if (!controller.isScreenShared) {
          return AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: controller.engine,
              canvas: const VideoCanvas(uid: 0),
            ),
          );
        } else {
          return AgoraVideoView(
              controller: VideoViewController(
            rtcEngine: controller.engine,
            canvas: const VideoCanvas(
              uid: 0,
              sourceType: VideoSourceType.videoSourceScreen,
            ),
          ));
        }
      } else {
        return const Text(
          'Join a channel',
          textAlign: TextAlign.center,
        );
      }
    });
  }
}

/// Display remote user's video
class RemoteVideo extends GetWidget<CallController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CallController>(builder: (CallController controller) {
      if (controller.remoteUid != null) {
        print("Widget remote uid :${controller.remoteUid}");
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: controller.engine,
            canvas: VideoCanvas(uid: controller.remoteUid),
            connection: RtcConnection(channelId: controller.room),
          ),
        );
      } else {
        String msg = '';
        if (controller.localUserJoined) {
          msg = 'في انتظار المستخدم الأخر للأنضمام';
        }
        return Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(color: Styles.primaryColor, fontSize: 18),
        );
      }
    });
  }
}
