import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/notification.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //when app is in terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data['route'];
        print(routeFromMessage);
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    // when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        // final routeFromMessage = message.data['route'];
        // Navigator.of(context).pushNamed(routeFromMessage);
      }
      // this will create channel and show heads up notification
      NotificationServices.display(message);
    });
    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        final routeFromMessage = message.data['route'];
        print(routeFromMessage);
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(33),
        child: Center(
          child: Column(
            children: [
              Text(
                'flutter firebase push notification',
                style: TextStyle(fontSize: 38),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        SubscribeTopic1();
                      },
                      child: Text('topic1')),
                  SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {
                        SubscribeTopic2();
                      },
                      child: Text('topic2'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
