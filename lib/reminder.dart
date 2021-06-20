import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'constant.dart';
import 'my_drawer.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {

  Widget itemReminder(String hour, List<String> dayList) {

    String daysString = "";

    for (int i = 0; i < dayList.length; i++) {
      if (i == dayList.length - 1) daysString += dayList[i];
      else daysString += dayList[i] + ", ";
    }

    return Center (
      child: Container(
        width: margeWidth(context),
        height: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(1, 2),
            )
          ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                CloseButton(
                  onPressed: () {
                    // delete reminder
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Text(
                      hour,
                      style: TextStyle(
                          fontSize: lg,
                          color: Color(fontColor2)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Repeat",
                          style: TextStyle(
                              fontSize: sm,
                              color: Color(fontColor2)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          daysString,
                          style: TextStyle(
                              fontSize: xsm,
                              color: Color(fontColor2)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: SizedBox()
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: OutlinedButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Disabled",
                      style: TextStyle(
                          color: Color(mainColor)
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Rappel", hasBackArrow: false),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(height: 20),
          itemReminder("22:00", ["Mon","Tue","Sat"]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Color(mainColor),
        child: Icon(
          Icons.add
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}