import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bhu_app/pages/home.dart';
import 'package:bhu_app/pages/about.dart';
import 'package:bhu_app/pages/contact.dart';
import 'package:bhu_app/pages/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/about': (context) => AboutUs(),
        '/contact': (context) => ContactUs(),
        '/data': (context) => MyData(),
      },
    );
  }
}
