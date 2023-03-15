import 'package:flutter/material.dart';

class GreenPage extends StatelessWidget {
  const GreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Text(
          'this is red screen',
          style: TextStyle(color: Color.fromARGB(255, 223, 223, 215)),
        )),
      ),
    );
  }
}
