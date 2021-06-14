import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int infoColor = 0xFF6090B2;

class CoachInfo extends StatefulWidget {
  @override
  _CoachInfoState createState() => _CoachInfoState();
}

class _CoachInfoState extends State<CoachInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COACH",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                      image: AssetImage('images/ronald.jpg'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Ronald DURANT",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Hello, I have been a coach for 10 years and I think I can teach you many things"
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
                      color: Color(infoColor).withOpacity(0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "City : " + "Paris"
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Availabity : " + "everyday of the week"
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Price : " + "5\$ " + "per hour"
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Phone : " + "06.00.00.00.00"
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Text(
                              "Email : " + "example@yahou.fr"
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
