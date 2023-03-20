import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/pages/serach_page.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pages/profie_page.dart';
import 'package:chat_app/helper/helper_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  Authservices authService = Authservices();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSP().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getuserNameFromSP().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(context, SearchPage());
                },
                icon: Icon(Icons.search))
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Groups",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        drawer: Drawer(
            child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 50),
                children: [
              Icon(Icons.account_circle, size: 150, color: Colors.grey[700]),
              SizedBox(height: 16),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              const Divider(height: 2),
              ListTile(
                  onTap: () {},
                  selectedColor: Theme.of(context).primaryColor,
                  selected: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: Icon(Icons.group),
                  title: const Text(
                    "Groups",
                    style: TextStyle(color: Colors.black),
                  )),
              ListTile(
                  onTap: () {
                    nextScreen(
                        context, ProfilePage(userName: userName, email: email));
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: Icon(Icons.person),
                  title: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.black),
                  )),
              ListTile(
                  onTap: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("LogOut"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    await authService.signOut();
                                    nextScreen(context, const LoginPage());
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )),
                            ],
                          );
                        });
                    // authService.signOut().whenComplete(() {
                    //   nextScreenReplace(context, LoginPage());
                    // }
                    // );
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text(
                    "LogOut",
                    style: TextStyle(color: Colors.black),
                  ))
            ])));
  }
}
