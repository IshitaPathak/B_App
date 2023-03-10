import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_firebase/home.dart';
import 'package:local_notification_firebase/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(BackgoroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channels);

  // var initializationSettingAndroid =
  //     AndroidInitializationSettings('@drawable/logo');
  // var initializationSetting =
  //     InitializationSettings(android: initializationSettingAndroid);

  // // for iOS Configuration
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true, //required to display notification on device
  //   badge: true, //for indicator purpose
  //   sound: true,
  // );

  FirebaseMessaging.onMessage.listen(ForegroundHandler);

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home(),
    );
  }
}
