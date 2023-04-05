import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:bhu_app/pages/data_load.dart';

class Student_Details extends StatefulWidget {
  const Student_Details({super.key});

  @override
  State<Student_Details> createState() => _Student_DetailsState();
}

class _Student_DetailsState extends State<Student_Details> {
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
        title: Text('Students Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            data['student_details'].length,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: ${data['student_details'][index]['name']}'),
                Text('Email: ${data['student_details'][index]['email']}'),
                Text(
                    'Mobile No: ${data['student_details'][index]['mobile no']}'),
                Text('Course: ${data['student_details'][index]['course']}'),
                SizedBox(
                    height:
                        20), //this will add some spacing between each student's details
              ],
            ),
          ),
        ),
      ),
    );
  }
}
