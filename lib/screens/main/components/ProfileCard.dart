import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      onTap: () {},
      child: Tooltip(
        message: 'Profile',
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
      ),
    );
  }
}
