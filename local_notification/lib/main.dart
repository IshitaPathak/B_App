import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_10y.dart';
import 'package:timezone/timezone.dart';
import 'package:notification1/notification.dart';

FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeTimeZones();

  // initializating setting for android
  AndroidInitializationSettings androidSetting =
      AndroidInitializationSettings('logo');

  // initialization setting for ios
  DarwinInitializationSettings iosSetting =
      DarwinInitializationSettings(defaultPresentSound: true);

  // combined iniialized setting
  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);

  bool? initialized =
      await notificationPlugin.initialize(initializationSettings);

  print("notification: $initialized");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter local notification')),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: showNotification,
                  icon: Icon(Icons.notifications),
                  label: Text('simple notification')),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: showScheduleNotification,
                  icon: Icon(Icons.notifications_active),
                  label: Text('scheduled notification')),
            ],
          ),
        ),
      ),
    );
  }
}
