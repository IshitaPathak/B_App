import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bhu_app/pages/contact.dart';

// two main ways to get the list of documents
// 1. call get() collection reference, this will gives a Future (we can't listen to Future)
// 2. by calling function snapshots() on collection reference, and this returns stream

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  late Stream<QuerySnapshot> dataItems;

  @override
  void initState() {
    super.initState();
    dataItems = FirebaseFirestore.instance.collection('Users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dataItems,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot userData = snapshot.data!.docs[index];
              return ListTile(
                  title: Column(
                children: [
                  Text(userData['field1']),
                  Text(userData['field2']),
                  Text(userData['field3'])
                ],
              ));
            },
          );
        },
      ),
    );
  }
}
