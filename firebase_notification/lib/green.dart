import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  const RedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Text(
          'this is greeeeeeeeeeeeeeeeeeeeeeenn screen',
          style: TextStyle(color: Colors.yellow),
        )),
      ),
    );
  }
}
