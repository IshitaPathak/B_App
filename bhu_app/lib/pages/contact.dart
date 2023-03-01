import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

class ContactUs extends StatelessWidget {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController message = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BHU-APP'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'Name:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2,
                      fontSize: 14,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'Email:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'Message:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  // expands: true,
                  maxLines: null,
                  minLines: 1,
                  controller: message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your message',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> data = {
                      'field1': name.text,
                      'field2': email.text,
                      'field3': message.text,
                    };
                    try {
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .add(data);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Message has been sent successfully',
                        autoCloseDuration: Duration(seconds: 4),
                        // backgroundColor: Colors.blue,
                      );
                    } catch (error) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Error has been ocoured :${error.toString()}',
                          autoCloseDuration: Duration(seconds: 3));
                    }
                  },
                  child: const Text('SUBMIT'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    name.clear();
                    email.clear();
                    message.clear();
                  },
                  child: Text('RESET'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
