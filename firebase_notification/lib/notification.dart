import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// flutter local notification allows you to create notification channel
class NotificationServices {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final NotificationDetails notifyDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              'demoNotificationChannel_id', 'channelName',
              channelDescription: 'this is description',
              importance: Importance.max,
              priority: Priority.max));

      await notificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notifyDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}

void SubscribeTopic1() async {
  await FirebaseMessaging.instance
      .subscribeToTopic('topic1')
      .then((value) => print('topic1 is subscried'));
  await FirebaseMessaging.instance.unsubscribeFromTopic('topic2');
  NotificationServices();
}

void SubscribeTopic2() async {
  await FirebaseMessaging.instance
      .subscribeToTopic('topic2')
      .then((value) => print('topic2 is subscried'));
  await FirebaseMessaging.instance.unsubscribeFromTopic('topic1');
  NotificationServices();
}
//note -
//In the onMessage when we receive the message from the firebase we can make use of this display method, 
//this will not just show the message on screen as a heads up notification but it will also create the 
//notification channel so that we can also use it in background noification also bcz in case of  background 
//when we receive notification we don't have do to anything else or use any other package to show heads up
//notification , you just have to create a channel and have to specify channel id
// but in case of foreground notification you have to use this flutter local notification bcz firebase doesn't 
//show heads up notification or even the notiification in the system tray while the app is in foreground 