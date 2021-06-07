import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';
import 'package:sm_home_nbcha/models/user_model.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'package:sm_home_nbcha/screens/main/main_screen.dart';
import 'package:sm_home_nbcha/screens/signup/signup_screen.dart';
import 'package:sm_home_nbcha/widgets/loading_progress_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signin_screen extends StatefulWidget {
  static const String routeName = '/';
  Signin_screen({Key key}) : super(key: key);

  @override
  _Signin_screenState createState() => _Signin_screenState();
}

class _Signin_screenState extends State<Signin_screen> {
  final _signFormKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool isLoading = false;
  bool isShowResult = false;
  bool isVisibility = false;

  void submitData() {
    setState(() {
      isLoading = true;
    });

    doRequestSignin(_usernameController.text, _passwordController.text)
        .then((value) {
      // print('RES => ' + value.body);

      Map response = jsonDecode(value.body)['responseMessage'] == null
          ? {'error': 'error'}
          : jsonDecode(value.body)['responseMessage'];

      if (response['error'] != null) {
        setState(() {
          isLoading = false;
          isVisibility = false;
          isShowResult = true;
        });
      } else {
        // print('USER Login =>' + user.toString());
        setState(() {
          isVisibility = false;
          isShowResult = false;
        });
        User user = User(
          id: response['id'].toString(),
          fname: response['fname'].toString(),
          lname: response['lname'].toString(),
          token: response['token'].toString(),
        );
        Provider.of<Devices>(context, listen: false).save(user);
        Navigator.of(context).popAndPushNamed(Main_screen.routeName);
      }
    });
  }

  Future<http.Response> doRequestSignin(
      String username, String password) async {
    return http.post(
      Uri.parse('https://smarthome-backend-chban.com/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
  }

  InputDecoration getInputDecoration(String labelText, Widget suffixIcon) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      // labelText: labelText,
      border: InputBorder.none,
      hintText: labelText,
      // enabledBorder: OutlineInputBorder(
      //   // borderRadius: BorderRadius.circular(16),
      //   // borderSide: BorderSide(color: Colors.black),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var medisQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'logo.svg',
                  width: 200,
                ),
                SizedBox(
                  height: 8.0,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'SMART HOME\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 50),
                      ),
                      TextSpan(
                        text: 'NBCHA company',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 22,
                            color: secondaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  color: Colors.amberAccent,
                ),
              ],
            ),
          ),
          Form(
            key: _signFormKey,
            child: Container(
              // color: primaryColor,
              width: medisQuery.width * 0.3,
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign in\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                        child: Text('sign up'),
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   height: 16.0,
                  // ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0XFFEFF3F6),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(6, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            offset: Offset(-6, -2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0)
                      ],
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      obscureText: false,
                      decoration: getInputDecoration('Username', null),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter username';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0XFFEFF3F6),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(6, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0),
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            offset: Offset(-6, -2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0)
                      ],
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: isVisibility,
                      decoration: getInputDecoration(
                        'Password',
                        IconButton(
                          icon: Icon(isVisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isVisibility = !isVisibility;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }

                        return null;
                      },
                    ),
                  ),
                  if (isLoading) LinearLoadingWidget(),
                  if (isShowResult)
                    Text(
                      'Account not found',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  InkWell(
                    onTap: () {
                      if (_signFormKey.currentState.validate()) {
                        submitData();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              offset: Offset(6, 2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0),
                          BoxShadow(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              offset: Offset(-6, -2),
                              blurRadius: 6.0,
                              spreadRadius: 3.0)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
