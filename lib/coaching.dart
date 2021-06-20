import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coach_info.dart';
import 'package:opitraining/training_plan.dart';

import 'Coach.dart';
import 'coach_login.dart';
import 'constant.dart';
import 'main.dart';

class Coaching extends StatefulWidget {
  @override
  _CoachingState createState() => _CoachingState();
}

class _CoachingState extends State<Coaching> {

  TextEditingController _searchQueryController = TextEditingController();
  List<Coach> coachList = [];
  final db = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();

    List<String> dayList = [];
    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).once().then((DataSnapshot data) {

      Map<dynamic,dynamic> users = data.value;

      users.forEach((key, value) {
        if (users[key]["is_coach"]) {
          dayList = [];
          users[key]["coach_info"]["availability"].forEach((key, value) {
            if (value) {
              dayList.add(key);
            }
          });
          setState(() {
            coachList.add(Coach(users[key]["coach_info"]["first_name"], users[key]["coach_info"]["name"], users[key]["coach_info"]["city"], users[key]["coach_info"]["price"], dayList, users[key]["coach_info"]["phone"], users[key]["coach_info"]["description"], users[key]["coach_info"]["email"]));
          });
        }
      });
    });
  }

  Widget coachItem(Coach coach) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoachInfo(coach: coach)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(secondaryColor),
        ),
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.02),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.width * 0.20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/ronald.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                      coach.getFirstName() + " " + coach.getName(),
                      style: TextStyle(
                          color: Color(fontColor2),
                          fontSize: lg
                      )
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ville : " + coach.getCity(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                      "Jour de disponible : " + coach.toStringDayAvailable(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                      "Price : " + " " + coach.getPricePerHour().toString() + "\$ " + " par heure"
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                      "Equipment : " + "Dumbbells, traction bar, iron bar and weight"
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Padding(
          child: TextField(
            controller: _searchQueryController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              fillColor: Color(tertiaryColor).withOpacity(0.35),
              filled: true,
              focusedBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                  )
              ),
              enabledBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                  )
              ),
              hintText: "Search",
              hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: lg
              )
            ),
          ),
          padding: EdgeInsets.only(left: 40,right: 40),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: coachList.length,
            itemBuilder: (BuildContext context, int index) {
              return coachItem(coachList[index]);
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ),
        ),
      ],
    );
  }
}