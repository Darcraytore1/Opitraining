import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/ItemCalendar.dart';
import 'package:opitraining/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';

/// This widget must provide the capacity to create a schedule to organize the
/// moment where the user is going to make one or another exercise.

class ScheduleChoice extends StatefulWidget {
  @override
  _ScheduleStateChoice createState() => _ScheduleStateChoice();
}

class _ScheduleStateChoice extends State<ScheduleChoice> {

  final dbToDo = FirebaseDatabase.instance.reference().child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_schedule).child(opi_dt_toDo);

  List<ItemCalendar> toDo = [];
  List<ItemCalendar> done = [];

  @override
  void initState() {
    super.initState();

    DateTime day;
    TimeOfDay time;

    dbToDo.once().then((DataSnapshot data) {
      Map<dynamic,dynamic> toDo = data.value;
      if (toDo != null) {
        toDo.forEach((key, value) {
          day = DateTime.parse(value["day"]);
          time = TimeOfDay(hour: value["time"]["hour"], minute: value["time"]["minute"]);
          setState(() {
            this.toDo.add(ItemCalendar(key, time, day));
          });
        });
      }
    });

    toDo.sort((a,b) {
      return a.compareTo(b);
    });
  }

  Widget itemCalendar(ItemCalendar item, String title) {
    return Container(
      width: margeWidth(context),
      decoration: BoxDecoration(
        color: Color(mainColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.15),
            child: Column(
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(item.getDay())+ ", " + "${item.getHour().format(context)}",
                  style: TextStyle(
                      color: Color(fontColor1),
                      fontSize: sm
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  title,
                  style: TextStyle(
                      color: Color(fontColor1),
                      fontSize: lg
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Column(
            children: [
              IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.edit)
              ),
              IconButton(
                  onPressed: () {
                    dbToDo.child(item.id).remove();
                    toDo.remove(item);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete)
              ),
            ],
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "CALENDRIER", hasBackArrow: false),
      drawer: MyDrawer(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),

            onDaySelected: (selectedDay, focusedDay) async {

              if (selectedDay.isAfter(DateTime.now())) {
                TimeOfDay _time;

                _time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: 20, minute: 00),
                );

                setState(() {
                  if (_time != null) {

                    DatabaseReference newRef = dbToDo.push();
                    toDo.add(ItemCalendar(newRef.key,_time, selectedDay));
                    toDo.sort((a,b) {
                      return a.compareTo(b);
                    });

                    dbToDo.push().set(
                        {
                          "day" : selectedDay.toIso8601String(),
                          "time" : {
                            "hour" : _time.hour,
                            "minute" : _time.minute
                          }
                        }
                    );
                  }
                });
              }
            },
          ),
          Text(
            "A faire",
            style: TextStyle(
                color: Color(mainColor),
                fontSize: lg
            ),
          ),
          Container(
            width: margeWidth(context),
            height:  MediaQuery.of(context).size.height * 0.30,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: toDo.length,
              itemBuilder: (BuildContext context, int index) {
                return itemCalendar(toDo[index], "Classique");
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ),
          ),
          /*
          Text(
            "Fait",
            style: TextStyle(
                color: Color(mainColor),
                fontSize: lg
            ),
          ),
          Container(
            width: margeWidth(context),
            height:  MediaQuery.of(context).size.height * 0.15,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: done.length,
              itemBuilder: (BuildContext context, int index) {
                return Container();
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ),
          ),
           */
        ],
      )
    );
  }
}