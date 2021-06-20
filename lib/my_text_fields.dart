import 'package:flutter/material.dart';

import 'constant.dart';

class MyTextFields extends StatefulWidget {

  final String placeholder;
  final TextEditingController controller;
  final bool isPassword;

  MyTextFields({Key key, this.placeholder, this.controller, this.isPassword}) : super (key: key);

  @override
  _MyTextFieldsState createState() => _MyTextFieldsState();
}

class _MyTextFieldsState extends State<MyTextFields> {

  Widget basicTextField(String placeholder, TextEditingController controller, bool isPassword) {
    return new Container(
      width: margeWidth(context),
      child: Theme(
        data: ThemeData (
          primaryColor: Color(mainColor),
        ),
        child: new TextField(
          controller: controller,
          obscureText: isPassword,
          enableSuggestions: !isPassword,
          autocorrect: !isPassword,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color(mainColor),
                      width: 2
                  )
              ),
              enabledBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(mainColor),
                  )
              ),
              hintText: placeholder,
              hintStyle: TextStyle(
                  color: Color(mainColor),
                  fontSize: lg
              )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return basicTextField(widget.placeholder, widget.controller, widget.isPassword);
  }
}
