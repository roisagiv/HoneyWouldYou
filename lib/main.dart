import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:honeywouldyou/Theme.dart';
import 'package:honeywouldyou/home/HomePage.dart';

void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info.
  enableFlutterDriverExtension();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.main(context),
      home: new HomePage(),
    );
  }
}
