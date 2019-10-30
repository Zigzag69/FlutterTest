import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            "Flutter Test App",
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ));
  }
}
