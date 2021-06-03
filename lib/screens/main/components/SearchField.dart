import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFEFF3F6),
        borderRadius: BorderRadius.circular(48.0),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(6, 2),
              blurRadius: 6.0,
              spreadRadius: 3.0),
          BoxShadow(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              offset: Offset(-6, -2),
              blurRadius: 6.0,
              spreadRadius: 3.0)
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          // fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(48)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              // padding: EdgeInsets.all(defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                // color: primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
