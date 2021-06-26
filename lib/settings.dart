import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';

import 'constant.dart';
import 'my_drawer.dart';

/// This widget show the settings of the user like the rest time between each
/// exercise, he can thus for example change the the time of his training rest

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Widget itemSetting(String settingName, Icon icon) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.black
            )
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.08),
              child: icon,
            ),
            Text(
              settingName,
              style: TextStyle(
                  color: Color(fontColor2),
                  fontSize: med
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: opiStrTitleSettingsPage, hasBackArrow: false),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            "ENTRAINEMENT",
            style: TextStyle(
                fontSize: lg,
                color: Color(mainColor)
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          itemSetting("Temps de repos", Icon(Icons.title)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Text(
            "PARAMETRES GENERAUX",
            style: TextStyle(
                fontSize: lg,
                color: Color(mainColor)
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          itemSetting("Langue", Icon(Icons.language)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          /*
          itemSetting("Keep the screen on", Icon(Icons.phone_android)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
           */
        ]
      ),
    );
  }
}
