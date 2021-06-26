import 'package:flutter/material.dart';

class ItemDrawer {
  String title;
  IconData iconData;

  ItemDrawer(String title, IconData iconData) {
    this.title = title;
    this.iconData = iconData;
  }

  String getTitle() {
    return title;
  }

  IconData getIconData() {
    return iconData;
  }
}