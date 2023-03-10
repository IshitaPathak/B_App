import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String channelGroupID = 'Grouping_All_Notification';
//create group first
const AndroidNotificationChannelGroup androidNotificationChannelGroup =
    AndroidNotificationChannelGroup(channelGroupID, 'group_name',
        description: 'channel description');

// Intializing flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initializing notification channel for android
const AndroidNotificationChannel channels = AndroidNotificationChannel(
    'flutter firebase notification id',
    'flutter firebase notification name title',
    description: 'this channel is used for all important notification',
    groupId: channelGroupID,
    importance: Importance.max,
    playSound: true);

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

class FirebaseNotification {
  initialize() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(BackgoroundHandler);

    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannelGroup(androidNotificationChannelGroup);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channels);

    var initializationSettingAndroid = AndroidInitializationSettings('logo');
    var initializeSetting =
        InitializationSettings(android: initializationSettingAndroid);

    flutterLocalNotificationsPlugin.initialize(initializeSetting);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(channels.id, channels.name,
                importance: Importance.max,
                priority: Priority.high,
                groupKey: channels.groupId);

        NotificationDetails platformSpecificNotificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            platformSpecificNotificationDetails);
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
    });
  }

  // subscribeToTopic(String topic) async {
  //   await FirebaseMessaging.instance.subscribeToTopic(topic);
  // }
}
