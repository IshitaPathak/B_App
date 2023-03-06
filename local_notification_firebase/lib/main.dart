import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_firebase/home.dart';

// Initializing notification channel for android
const AndroidNotificationChannel channels = AndroidNotificationChannel(
    'flutter firebase notification id',
    'flutter firebase notification name title',
// 'this channel is used for all important notification',//description
    importance: Importance.max,
    playSound: true);

// Intilizing flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// this is top-level function to handle background message
// It just initializes the firebase app once the notification
// is received when the app is in background
Future<void> _firebaseMessagingBackgoroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print('Background message is showed up');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgoroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channels);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, //required to display a heads up notification
    badge: true,
    sound: true,
  );
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
