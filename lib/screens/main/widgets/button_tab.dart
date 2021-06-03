import 'package:flutter/material.dart';
import 'package:sm_home_nbcha/constance.dart';

class ButtonTabWidget extends StatefulWidget {
  final Widget icon;
  final Function function;
  ButtonTabWidget({Key key, this.icon, this.function}) : super(key: key);

  @override
  _ButtonTabWidgetState createState() => _ButtonTabWidgetState();
}

class _ButtonTabWidgetState extends State<ButtonTabWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // width: widget.size.width,
      // height: widget.size.height,
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: secondaryColor,
      //   // border: BoxBorder.lerp(a, b, t)
      // ),
      child: widget.icon,
      onPressed: widget.function,
    );
  }
}
