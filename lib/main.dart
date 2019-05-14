import 'package:chaming/src/screens/sign.dart';
import 'package:flutter/material.dart';
// import 'package:chaming/src/services/authentication.dart';
// import 'package:chaming/src/utils/app_root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chaming',
      debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Sign(),
        // home: new Root(auth: new Auth())
    );
  }
}