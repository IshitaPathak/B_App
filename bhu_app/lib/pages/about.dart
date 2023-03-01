import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BHU-APP'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc4oVZyg4zb5q1qi4tXpkoZNXDUFRY9yO7Dw&usqp=CAU'),
                radius: 60,
              )),
              Divider(
                height: 30,
                color: Colors.grey[700],
              ),
              Text('Hostel Name',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2,
                  )),
              Text(
                'Pragya Kunj Hostel',
                style: TextStyle(
                  color: Colors.blue,
                  letterSpacing: 2,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey[400],
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Department of CS',
                    style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
