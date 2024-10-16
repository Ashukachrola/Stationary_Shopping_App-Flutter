import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  final String title;

  MyAccountPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('$title Page Content'),
      ),
    );
  }
}
