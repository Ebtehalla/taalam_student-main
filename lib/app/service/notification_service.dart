//import 'package:onesignal_flutter/onesignal_flutter.dart';

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/timeslot_service.dart';
import 'package:hallo_doctor_client/app/utils/styles/styles.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_important_channel",
  "High Importance Notifications",
  description: 'this channel is used for important notification',
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessaggingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('a big message just show up ${message.messageId!}');
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaggingBackgroundHandler);
    setupFlutterNotification();
    setupTimezone();
    setupNotificationAction();
  }
  void setupFlutterNotification() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      "testing",
      "How you doing",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Styles.primaryColor,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          print('masuk notifikasinya');
          if (message.data['type'] == 'call') {
            await showCallNotification(
                message.data['fromName'],
                message.data['roomName'],
                message.data['token'],
                message.data['timeSlotId']);
          } else {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Styles.primaryColor,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
            );
          }
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('a new message opened app are was published');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          Get.defaultDialog(
            title: notification.title ?? "",
            content: Text(notification.body ?? 'body empty'),
          );
        }
      },
    );
  }

  void setupTimezone() async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    printInfo(info: 'local timezone : ' + currentTimeZone);
  }

  void setupNotificationAction() async {
    FlutterCallkitIncoming.onEvent.listen(
      (event) async {
        switch (event?.event) {
          case Event.actionCallIncoming:
            print('incoming call gaes');
            break;
          case Event.actionCallAccept:
            print('body ' + event?.body['extra']['roomName']);
            print('accept the data');
            TimeSlot selectedTimeslot = await TimeSlotService()
                .getTimeSlotById(event?.body['extra']['selectedTimeslotId']);
            Get.toNamed('/video-call', arguments: [
              {
                'timeSlot': selectedTimeslot,
                'room': event?.body['extra']['roomName'],
                'token': event?.body['extra']['token']
              }
            ]);
            break;
          case Event.actionCallDecline:
            print('decline call goes');
            break;
          case Event.actionCallStart:
            break;
          case Event.actionCallEnded:
            break;
          case Event.actionCallTimeout:
            break;
          case Event.actionCallCallback:
            break;
          case Event.actionCallToggleHold:
            break;
          case Event.actionCallToggleMute:
            break;
          case Event.actionCallToggleDmtf:
            break;
          case Event.actionCallToggleGroup:
            break;
          case Event.actionCallToggleAudioSession:
            break;
          case Event.actionDidUpdateDevicePushTokenVoip:
            break;
          case Event.actionCallCustom:
            break;
          case null:
        }
      },
    );
  }

  Future showCallNotification(String fromName, String roomName, String token,
      String selectectedTimeslotId) async {
    await FlutterCallkitIncoming.showCallkitIncoming(
      CallKitParams(
        nameCaller: fromName,
        appName: "Taalam",
        type: 1,
        avatar: '',
        duration: 30000,
        textAccept: 'Accept',
        textDecline: 'Decline',
        missedCallNotification: NotificationParams(
          isShowCallback: false,
          callbackText: "Call back",
          subtitle: "Missed Call",
          showNotification: true,
        ),
        extra: <String, dynamic>{
          'roomName': roomName,
          'token': token,
          'selectedTimeslotId': selectectedTimeslotId
        },
        headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
        android: AndroidParams(
          actionColor: '#4CAF50',
          isCustomNotification: true,
          ringtonePath: 'system_ringtone_default',
          backgroundUrl: 'https://i.pravatar.cc/500',
          backgroundColor: '#0955fa',
        ),
        ios: IOSParams(
            iconName: 'CallKitLogo',
            handleType: 'generic',
            supportsVideo: true,
            maximumCallGroups: 2,
            maximumCallsPerCallGroup: 1,
            audioSessionMode: 'default',
            audioSessionActive: true,
            audioSessionPreferredSampleRate: 44100.0,
            audioSessionPreferredIOBufferDuration: 0.005,
            supportsDTMF: true,
            supportsHolding: true,
            supportsUngrouping: false,
            supportsGrouping: false,
            ringtonePath: 'system_ringtone_default'),
      ),
    );
  }

  Future<String?> getNotificationToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future testNotification() async {
    try {
      await FirebaseFunctions.instance.httpsCallable('notificationTest').call();
      //var clientSecret = results.data;
      print('send notification : ');
      //return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //set local notification before appoinment time
  setNotificationAppointment(DateTime time) {
    var notificationDate =
        Jiffy.parseFromDateTime(time).subtract(minutes: 10).dateTime;
    printInfo(
      info: 'Date time sebelum TZ Date (dikurang 10 menit): $notificationDate',
    );
    var myTzDatetime = tz.TZDateTime.local(
      notificationDate.year,
      notificationDate.month,
      notificationDate.day,
      notificationDate.hour,
      notificationDate.minute,
      notificationDate.second,
      notificationDate.millisecond,
    );
    printInfo(info: 'Date time setelah TZ Date $myTzDatetime');
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Consultation will start soon',
      "The consultation session will start in 10 minutes",
      myTzDatetime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Styles.primaryColor,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    printInfo(info: 'set local notification 10 before notification happen');
  }
}
