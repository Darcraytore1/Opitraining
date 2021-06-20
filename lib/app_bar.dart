import 'package:flutter/material.dart';
import 'package:opitraining/constant.dart';


class MyAppBar extends StatefulWidget with PreferredSizeWidget {

  final String title;
  final bool hasBackArrow;

  MyAppBar({Key key, this.title, this.hasBackArrow}) : super (key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class _MyAppBarState extends State<MyAppBar> {

  @override
  Widget build(BuildContext context) {
    if (widget.hasBackArrow) {
      return AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              color: Color(fontColor2)
          ),
        ),
        backgroundColor: Color(backgroundColor),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }

    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
            color: Color(fontColor2)
        ),
      ),
      iconTheme: IconThemeData(color: Color(mainColor)),
      backgroundColor: Colors.white,
    );
  }
}
