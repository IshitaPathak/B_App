import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_firebase/main.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channels.id, channels.name,
                    channelDescription: 'welcome',
                    color: Colors.red,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onmessaged opened app is trigered');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(notification.body!)]),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Notification'),
        centerTitle: true,
      ),
      body: ElevatedButton.icon(
          onPressed: () {
            flutterLocalNotificationsPlugin.show(
                0,
                'notification title',
                'welcome to the app',
                NotificationDetails(
                    android: AndroidNotificationDetails(
                        channels.id, channels.name,
                        channelDescription: 'hiiiiiii welcome',
                        importance: Importance.max,
                        color: Colors.red,
                        playSound: true,
                        icon: '@mipmap/ic_launcher')));
          },
          icon: Icon(Icons.notifications),
          label: Text('Notification')),
    );
  }
}
