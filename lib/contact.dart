import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';

import 'constant.dart';
import 'my_drawer.dart';

/// This widget provide a system of friends, you can see yours friends, add yours
/// friend then if you want you can share yours training with some of them

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "CONTACT", hasBackArrow: false),
      drawer: MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ElevatedButton(
              onPressed: () {
              },
              child: Text(
                "AJOUTER AMIS",
                style: TextStyle(
                    fontSize: lg,
                    color: Color(fontColor1)
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(mainColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.height * 0.025,MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.height * 0.025)
              ),
            ),
          ],
        ),
      )
    );
  }
}
