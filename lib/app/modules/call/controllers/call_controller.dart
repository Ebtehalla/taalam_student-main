import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../utils/environment.dart';
import 'package:permission_handler/permission_handler.dart';

class CallController extends GetxController {
  //TimeSlot orderedTimeslot = Get.arguments[0]['timeSlot'];
  String token = Get.arguments['token'];
  String room = Get.arguments['room'];
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  bool videoCallEstablished = false;
  bool isScreenShared = false;
  int? localUid;
  int? remoteUid;
  late RtcEngine engine;
  bool localAudioMute = false;
  bool localUserJoined = false;
  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();
    engine = createAgoraRtcEngine();
    //create the engine
    await engine.initialize(RtcEngineContext(
        appId: Environment.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
    await engine.enableVideo();
    await engine.setClientRole(
      role: ClientRoleType.clientRoleBroadcaster,
    );
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("local user ${connection.localUid} joined");
          localUserJoined = true;
          localUid = connection.localUid;
          update();
        },
        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          print("remote user $uid joined");
          remoteUid = uid;
          update();
        },
        onUserOffline:
            (RtcConnection connection, int uid, UserOfflineReasonType reason) {
          print("remote user $uid left channel");
          remoteUid = null;
          endMeeting();
          update();
        },
      ),
    );

    await engine.startPreview();
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await engine.joinChannel(
        token: token, channelId: room, uid: localUid ?? 0, options: options);
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {}

  void hangUp() async {
    Get.back();
  }

  Future<void> shareScreen() async {
    isScreenShared = !isScreenShared;

    if (isScreenShared) {
      engine.startScreenCapture(const ScreenCaptureParameters2(
          captureAudio: true,
          audioParams: ScreenAudioParameters(
              sampleRate: 16000, channels: 2, captureSignalVolume: 100),
          captureVideo: true,
          videoParams: ScreenVideoParameters(
              dimensions: VideoDimensions(height: 1280, width: 720),
              frameRate: 30,
              bitrate: 600)));
      update();
    } else {
      await engine.stopScreenCapture();
      update();
    }

    // Update channel media options to publish camera or screen capture streams
    ChannelMediaOptions options = ChannelMediaOptions(
      publishCameraTrack: !isScreenShared,
      publishMicrophoneTrack: !isScreenShared,
      publishScreenTrack: isScreenShared,
      publishScreenCaptureAudio: isScreenShared,
      publishScreenCaptureVideo: isScreenShared,
    );

    engine.updateChannelMediaOptions(options);
  }

  Future endMeeting() async {
    //  await VideoCallService().removeRoom(orderedTimeslot.timeSlotId!);
    await engine.leaveChannel();
    await engine.release();
    Get.back();
  }

  Future switchCamera() async {
    try {
      await engine.switchCamera();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future toggleLotcalAudioMuted() async {
    try {
      localAudioMute = !localAudioMute;
      await engine.muteLocalAudioStream(localAudioMute);
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
