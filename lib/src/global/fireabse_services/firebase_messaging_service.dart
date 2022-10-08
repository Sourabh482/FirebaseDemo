import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String FCM_TOKEN = "";

//NOTIFICATION CODE
AndroidNotificationChannel channel = AndroidNotificationChannel(
  'demo', // id
  'demo', // description
  playSound: true,
  showBadge: true,
  importance: Importance.max,
  enableLights: true,
  enableVibration: true,
);

class FireBaseMessagingService extends GetxService {
  Future<FireBaseMessagingService> init() async {
    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
    setToken();
    await fcmOnLaunchListeners();
    await fcmOnResumeListeners();
    await fcmOnMessageListeners();
    return this;
  }

  Future fcmOnMessageListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _newMessageNotification(message);
    });

    initializeNotificationSetting();
  }

  // when the application is terminated and click on the notification
  Future fcmOnLaunchListeners() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null && message.data.toString().trim() != "") {
      print("Intialize Message   ${message.data}");
      moveScreen(jsonEncode(message.data).toString());
    }
  }

  // app in background and call click on the notification
  Future fcmOnResumeListeners() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App Message Oppened  ${message.data["path"]}");
      print("NotificationDialog   $message");
      moveScreen(jsonEncode(message.data).toString());
    });
  }

  void _newMessageNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    //AndroidNotification? android = message.notification?.android;
    showNotification(notification!, "");
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: "plainCategory",
    );
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              playSound: true,
              enableVibration: true,
              enableLights: true,
              importance: Importance.max,
              priority: Priority.high,
              channelShowBadge: true,
            ),
            iOS: iosNotificationDetails),
        payload: jsonEncode(message.data));
  }

  Future onDidReceiveLocalNotification(
      dynamic id, dynamic title, dynamic body, dynamic payload) async {
    debugPrint("received tapped kill" + payload.toString());
    moveScreen(payload.toString());
  }

  // application is open and click on the notification
  // on select notifiction
  Future onSelectNotification(NotificationResponse notificationResponse) async {
    debugPrint("select tapped kill" + notificationResponse.payload.toString());
    moveScreen(notificationResponse.payload.toString());
  }

  void moveScreen(String json) {
    var jsonencoded = jsonDecode(json);
    if (jsonencoded["path"].toString() == "login") {
      Get.toNamed(Routes.screen_two);
    } else {
      Get.toNamed(Routes.screen_three);
    }
  }

  void initializeNotificationSetting() {
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  void setToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) {
        FCM_TOKEN = value;
        print("FCM TOKEN : ${value}");
      }
    }).catchError((onError) {
      print("onError====> $onError");
    });
  }

  void showNotification(RemoteNotification notification, String action) {}
}
