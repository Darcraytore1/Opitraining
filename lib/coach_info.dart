import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';
import 'package:opitraining/constant.dart';

import 'Coach.dart';
import 'constant.dart';

class CoachInfo extends StatefulWidget {

  final Coach coach;

  CoachInfo({Key key, this.coach}) : super (key: key);

  @override
  _CoachInfoState createState() => _CoachInfoState();
}

class _CoachInfoState extends State<CoachInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title : "COACH", hasBackArrow: true),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.coach.urlImage
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              widget.coach.getFirstName() + " " + widget.coach.getName(),
              style: TextStyle(
                color: Color(fontColor2),
                fontSize: lg
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.coach.getDescription()
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    "Equipment owned :"
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                      "Dumbbells, traction bar, iron bar and weights"
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Color(tertiaryColor).withOpacity(0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "City : " + widget.coach.getCity()
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Availabity : " + widget.coach.toStringDayAvailable()
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Price : " + widget.coach.getPricePerHour().toString() +"\$ " + "per hour"
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Phone : " + widget.coach.getPhone()
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Email : " + widget.coach.getEmail()
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
