import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'sign-up';
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var medisQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _signFormKey,
                child: Container(
                  width: medisQuery.width * 0.3,
                  padding: EdgeInsets.all(8.0),
                  child: Column(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
