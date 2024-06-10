import 'package:flutter/material.dart';
import 'package:flutter_application_1/WelcomePage.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
