import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'constant.dart';
import 'my_drawer.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SCHEDULE",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(color: Color(mainColor)),
        backgroundColor: Colors.white,
      ),
      drawer: MyDrawer(),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        onDaySelected: (selectedDay, focusedDay) {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 20, minute: 00),
          );
        },
      ),
    );
  }
}