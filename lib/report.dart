import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';

import 'constant.dart';
import 'my_drawer.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "RAPPORT", hasBackArrow: false),
      drawer: MyDrawer(),
    );
  }
}