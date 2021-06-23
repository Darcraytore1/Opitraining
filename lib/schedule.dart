import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import 'ItemCalendar.dart';
import 'app_bar.dart';
import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "A faire",
                style: TextStyle(
                    color: Color(mainColor),
                    fontSize: lg
                ),
              ),
              Container(
                width: margeWidth(context),
                height:  MediaQuery.of(context).size.height * 0.35,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: toDo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemCalendar(toDo[index], "Classique");
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "Fait",
                style: TextStyle(
                    color: Color(mainColor),
                    fontSize: lg
                ),
              ),
              Container(
                width: margeWidth(context),
                height:  MediaQuery.of(context).size.height * 0.35,
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
        )
    );
  }
}
