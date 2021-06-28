import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';
import 'package:opitraining/main.dart';

import 'constant.dart';
import 'my_drawer.dart';

/// This widget show the settings of the user like the rest time between each
/// exercise, he can thus for example change the the time of his training rest

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  int restTime = advisedTime;
  bool _isVisible = false;

  Widget itemSetting(String settingName, Icon icon) {
    return InkWell(
      onTap: () {
        _isVisible = true;
        setState(() {});
      },
      child: Padding(
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
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget itemSettingActive(String title) {
    return Visibility(
      visible: _isVisible,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0,3),
                )
              ]
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Text(
                title,
                style: TextStyle(
                  fontSize: lg
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          restTime -= 5;
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)
                  ),
                  SizedBox(width:  MediaQuery.of(context).size.width * 0.05),
                  Text(
                    _printDuration(Duration(seconds: restTime)),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: builderTime
                    ),
                  ),
                  SizedBox(width:  MediaQuery.of(context).size.width * 0.05),
                  IconButton(
                      onPressed: () {
                        restTime += 5;
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_forward_ios_sharp)
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  TextButton(
                    onPressed: () {
                      restTime = advisedTime;
                      _isVisible = false;
                      setState(() {});
                    },
                    child: Text(
                      "ANNULER",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: lg
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04, left: MediaQuery.of(context).size.width * 0.04),
                    child: TextButton(
                        onPressed: () {
                          db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userInfo).child("restTime").set(
                            restTime
                          );
                          advisedTime = restTime;
                          _isVisible = false;
                          setState(() {});
                        },
                        child: Text(
                          "VALIDER",
                          style: TextStyle(
                              fontSize: lg
                          ),
                        )
                    ),
                  )
                ],
              )
            ],
          ),
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
          itemSetting("Temps de repos", Icon(IconData(58984, fontFamily: 'MaterialIcons'))),
          itemSettingActive("Temps de repos")
          /*
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
           */
          /*
          itemSetting("Keep the screen on", Icon(Icons.phone_android)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
           */
        ]
      ),
    );
  }
}
