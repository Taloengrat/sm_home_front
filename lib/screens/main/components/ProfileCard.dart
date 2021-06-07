import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';
import 'package:provider/provider.dart';
import 'package:sm_home_nbcha/providers/devices.dart';
import 'package:sm_home_nbcha/screens/signin/signin_screen.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  void profileAction(String choise) {
    // print('object' + choise);
    switch (choise) {
      case 'Sign Out':
        Provider.of<Devices>(context, listen: false).clearStorage();
        Navigator.of(context).popAndPushNamed(Signin_screen.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Profile',
      onSelected: profileAction,
      offset: Offset(0, 55),
      itemBuilder: (ctx) {
        return Constants.choices.map((choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFEFF3F6),
          borderRadius: BorderRadius.circular(48.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 1),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ],
        ),
        width: 55,
        height: 55,
        margin: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage('images/profile.jpg'),
        ),
      ),
    );
  }
}
