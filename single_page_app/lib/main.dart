import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: StudentCard(),
    ));

class StudentCard extends StatefulWidget {
  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  int RollNo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Student ID Card'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0, //drop shadow of navbar is removed
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            RollNo += 1;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/photo.jpg'),
                  radius: 50,
                ),
              ),
              const Divider(
                height: 60,
                color: Colors.grey,
              ),
              const Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Ishita Pathak',
                style: TextStyle(
                  color: Colors.amber,
                  letterSpacing: 2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'COURSE',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'BSc. CS Hons.',
                style: TextStyle(
                  color: Colors.amber,
                  letterSpacing: 2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'HOSTEL NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Kriti Kunj',
                style: TextStyle(
                  color: Colors.amber,
                  letterSpacing: 2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'ROLL NO',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$RollNo',
                style: TextStyle(
                  color: Colors.amber,
                  letterSpacing: 2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey[400],
                  ),
                  SizedBox(width: 5),
                  Text(
                    'MMV BHU',
                    style: TextStyle(
                      color: Colors.grey[400],
                      letterSpacing: 1.5,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  SizedBox(width: 5),
                  Text(
                    'abc_bhu@gmail.com',
                    style: TextStyle(
                      color: Colors.grey[400],
                      letterSpacing: 1.5,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
