import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/ItemCalendar.dart';
import 'package:opitraining/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'constant.dart';
import 'my_drawer.dart';

/// This widget must provide the capacity to create a schedule to organize the
/// moment where the user is going to make one or another exercise.

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  List<ItemCalendar> toDo = [];
  List<ItemCalendar> done = [];

  Widget itemCalendar(ItemCalendar item, String title) {
    return Container(
      width: margeWidth(context),
      decoration: BoxDecoration(
        color: Color(tertiaryColor).withOpacity(0.35),
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
                  item.getDay().day.toString() + "/" + item.getDay().month.toString() + "/" + item.getDay().year.toString() + ", " + "${item.getHour().format(context)}",
                  style: TextStyle(
                      color: Color(fontColor2),
                      fontSize: sm
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  title,
                  style: TextStyle(
                      color: Color(fontColor2),
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

              TimeOfDay _time;

              _time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: 20, minute: 00),
              );

              setState(() {
                toDo.add(ItemCalendar(_time, selectedDay));
              });
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
            height:  MediaQuery.of(context).size.height * 0.15,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: toDo.length,
              itemBuilder: (BuildContext context, int index) {
                return itemCalendar(toDo[index], "Classique");
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ),
          ),
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
        ],
      )
    );
  }
}