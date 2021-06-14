import 'package:flutter/material.dart';
import 'package:opitraining/coach_info.dart';

import 'coach_login.dart';
import 'my_drawer.dart';

int searchColor = 0xFF6090B2;
int secondaryColor = 0xFF89D37D;

class Coaching extends StatefulWidget {
  @override
  _CoachingState createState() => _CoachingState();
}

class _CoachingState extends State<Coaching> {

  TextEditingController _searchQueryController = TextEditingController();

  Widget coachItem(String coachName) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoachInfo()),
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
                      coachName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
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
                    "City : " + "Paris",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                      "Availability : " + "everyday of the week"
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                      "Price : " + " 5\$ " + "per hour"
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
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            // Redirect to coach login page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CoachLogin()),
            );
          },
          child: Text(
            "Deviens coach",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(mainColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.fromLTRB(130,25,130,25)
          ),
        ),
        SizedBox(height: 50),
        Padding(
          child: TextField(
            controller: _searchQueryController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.youtube_searched_for),
              fillColor: Color(searchColor).withOpacity(0.35),
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
                  fontSize: 18
              )
            ),
          ),
          padding: EdgeInsets.only(left: 40,right: 40),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        coachItem("Ronald DURANT"),
      ],
    );
  }
}