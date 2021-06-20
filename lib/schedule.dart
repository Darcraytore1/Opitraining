import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "CALENDRIER", hasBackArrow: false),
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