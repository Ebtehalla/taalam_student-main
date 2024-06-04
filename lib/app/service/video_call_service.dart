import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

class DoctorVideoCallService {
  static Future notificationStartAppointment(
      {required String userId,
      required String notificationToken,
      required String channelName}) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('rescheduleTimeslot');
      var data = await callable({
        'channelName': channelName,
        'displayName': userId,
        'registrationToken': notificationToken
      });
      Get.log("FIREBASE NOTIFICATION DATA IS : $data");
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }

  static Future sendVideoCall({
    required String callerUid,
    required String receiveUid,
  }) async {
    try {
      const chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random rnd = Random();

      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('agoraCall');
      final resp = await callable.call(<String, dynamic>{
        'callerUid': callerUid,
        'receiverUid': receiveUid,
        'channelName': getRandomString(20)
      });
      Get.log("AGORA CALL : ${resp.data['data']}");
      return resp.data['data'];
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }
}
