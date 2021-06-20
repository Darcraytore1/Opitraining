import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';

import 'constant.dart';
import 'my_drawer.dart';

/// This widget must provide the information of report of one user, how that user
/// has respect his schedule, the weight he has loose ...

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