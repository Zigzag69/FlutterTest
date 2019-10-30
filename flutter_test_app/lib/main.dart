import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/ui/sign_in/sign_in_page.dart';
import 'package:flutter_test_app/ui/welcome/welcome_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}