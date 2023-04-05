import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/pages/serach_page.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/databse_services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

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
    // getting the list of snapshot in our streaam
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
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
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
          ])),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: Text(
                "Create a group",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor),
                        )
                      : TextField(
                          onChanged: (value) {
                            setState(() {
                              groupName = value;
                            });
                          },
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(10)))),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CANCEL"),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor)),
                ElevatedButton(
                    onPressed: () {
                      if (groupName != "") {
                        setState(() {
                          _isLoading = true;
                        });
                        DatabaseServices(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                userName,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName)
                            .whenComplete(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                        showSnackBar(context, Theme.of(context).primaryColor,
                            "Group created successfully");
                      }
                    },
                    child: Text("CREATE"),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor)),
              ],
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        //make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  return Text("Hello");
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                child:
                    Icon(Icons.add_circle, color: Colors.grey[700], size: 77)),
            SizedBox(height: 20),
            Text(
              'You have not joined any group, tap on the add icon above to create a group or also search existing group from top search button',
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
