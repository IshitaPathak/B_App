import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Initializing notification channel for android
const AndroidNotificationChannel channels = AndroidNotificationChannel(
    'flutter firebase notification id',
    'flutter firebase notification name title',
// 'this channel is used for all important notification',//description
    groupId: "Grouping_All_Notification",
    importance: Importance.max,
    playSound: true);

// Intilizing flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// this is top-level function to handle background message
// It just initializes the firebase app once the notification
// is received when the app is in background
Future<void> BackgoroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print('Background message is showed up');
}

Future<void> ForegroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("handling a foregroung message");
  if (message.notification != null) {
    print("notificaion message");
  }
}

subscribeToTopic(String topic) async {
  await FirebaseMessaging.instance.subscribeToTopic("topic");
}

void groupNotification() async {
  List<ActiveNotification>? activeNotification =
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();
  if (activeNotification != null && activeNotification.length > 0) {
    List<String> Onlytitles =
        activeNotification.map((e) => e.title.toString()).toList();
    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        Onlytitles,
        contentTitle: "${activeNotification.length} message");

    AndroidNotificationDetails groupNotificationDetails =
        AndroidNotificationDetails(channels.id, channels.name,
            styleInformation: inboxStyleInformation,
            setAsGroupSummary: true,
            groupKey: channels.groupId);
    NotificationDetails groupNotificationDetailsPlatformSepcific =
        NotificationDetails(android: groupNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, " ", " ", groupNotificationDetailsPlatformSepcific);
  }
}
