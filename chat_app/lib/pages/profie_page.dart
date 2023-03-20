import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Authservices authService = Authservices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: Text("Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold))),
        drawer: Drawer(
            child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 50),
                children: [
              Icon(Icons.account_circle, size: 150, color: Colors.grey[700]),
              SizedBox(height: 16),
              Text(
                // In the context of a Flutter widget, the widget keyword is used to access the properties or
                //variables defined in the widget's parent class. So, in the ProfilePage class, if a variable userName
                //is defined in the parent class (i.e., the widget that contains ProfilePage), then it can be accessed
                //using widget.userName.
                // If userName is not defined in the parent class, then it cannot be accessed using widget.userName.
                // In that case, userName would need to be defined directly in the ProfilePage class in order to be
                //accessed without using widget.
                widget.userName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              const Divider(height: 2),
              ListTile(
                  onTap: () {
                    nextScreen(context, HomePage());
                  },
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
                        context,
                        ProfilePage(
                          email: 'email',
                          userName: 'userName',
                        ));
                  },
                  selectedColor: Theme.of(context).primaryColor,
                  selected: true,
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
            ])),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 180),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle,
                size: 200,
                color: Colors.grey[700],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Full Name", style: TextStyle(fontSize: 17)),
                  Text(widget.userName, style: TextStyle(fontSize: 17)),
                ],
              ),
              Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email", style: TextStyle(fontSize: 17)),
                  Text(widget.email, style: TextStyle(fontSize: 17))
                ],
              )
            ],
          ),
        ));
  }
}
