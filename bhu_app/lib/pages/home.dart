import 'package:flutter/material.dart';
import 'package:bhu_app/pages/home.dart';
import 'package:bhu_app/pages/about.dart';
import 'package:bhu_app/pages/contact.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BHU-APP'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            // ignore: prefer_const_constructors
            DrawerHeader(
                child: Text('BHU APP'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrN-0Zyc0gRzQF18gBu3bpyOIcmvCu252xiQ&usqp=CAU'),
                  //   fit: BoxFit.fill,
                  // ),
                )),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                }),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('About Us'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: Icon(Icons.data_object),
              title: Text('FireStore data'),
              onTap: () {
                Navigator.pushNamed(context, '/data');
              },
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: Text('About Us')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/contact');
              },
              child: Text('Contact Us'))
        ],
      ),
    );
  }
}
