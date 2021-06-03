import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'package:sm_home_nbcha/providers/users.dart';
import 'package:sm_home_nbcha/screens/main/main_screen.dart';
import 'package:sm_home_nbcha/screens/signin/signin_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: Devices(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          backgroundColor: bgColor,
          accentColor: thirdColor,
          secondaryHeaderColor: secondaryColor,
          buttonTheme: ButtonThemeData(
              buttonColor: secondaryColor, textTheme: ButtonTextTheme.primary),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
        ),
        routes: {
          '/': (ctx) => Signin_screen(),
          Main_screen.routeName: (ctx) => Main_screen(),
        },
      ),
    );
  }
}
