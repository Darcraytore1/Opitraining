import 'package:flutter/material.dart';

import 'constant.dart';
import 'my_drawer.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CONTATCTS",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(color: Color(mainColor)),
        backgroundColor: Colors.white,
      ),
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
                    fontSize: 18,
                    color: Colors.white
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
