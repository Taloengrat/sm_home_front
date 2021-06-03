import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration inputDecoration;
  final bool obcure;
  const TextFieldWidget(
      {Key key, this.inputDecoration, this.obcure, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration,
      obscureText: obcure != null ? obcure : null,
    );
  }
}
