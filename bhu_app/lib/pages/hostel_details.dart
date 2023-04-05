import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:bhu_app/pages/data_load.dart';

class Hostel_Details extends StatefulWidget {
  const Hostel_Details({super.key});

  @override
  State<Hostel_Details> createState() => Hostel_DetailsState();
}

class Hostel_DetailsState extends State<Hostel_Details> {
  Map<String, dynamic> data = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData().then((value) => setState(() {
          data = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            data['hostel_detail'].length,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: ${data['hostel_detail'][index]['name']}'),
                Text('Email: ${data['hostel_detail'][index]['course']}'),
                Text(
                    'Mobile No: ${data['hostel_detail'][index]['number of rooms']}'),
                Text(
                    'Course: ${data['hostel_detail'][index]['price per room']}'),
                SizedBox(
                    height:
                        20), //this will add some spacing between each hostel's details
              ],
            ),
          ),
        ),
      ),
    );
  }
}
