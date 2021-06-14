import 'package:flutter/material.dart';

import 'coach_sign_up_4.dart';
import 'main.dart';

class CoachSignUp2 extends StatefulWidget {
  @override
  _CoachSignUp2State createState() => _CoachSignUp2State();
}

class _CoachSignUp2State extends State<CoachSignUp2> {

  final priceController = TextEditingController();
  final equipmentOwnedController = TextEditingController();

  // The seven days of one week
  final isSelected = [false,false,false,false,false,false,false];

  Widget basicTextField(String placeholder, TextEditingController controller, bool isPassword) {
    return new Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Theme(
        data: ThemeData (
          primaryColor: Color(mainColor),
        ),
        child: new TextField(
          controller: controller,
          obscureText: isPassword,
          enableSuggestions: !isPassword,
          autocorrect: !isPassword,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color(mainColor),
                      width: 2
                  )
              ),
              enabledBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(mainColor),
                  )
              ),
              hintText: placeholder,
              hintStyle: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18
              )
          ),
        ),
      ),
    );
  }

  Widget itemDay(String day, bool isSelected) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Color(mainColor)
        ),
      ),
      child: Center(
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(mainColor),
          ),
        ),
      ),
    );
  }

  /*
  Widget itemDaySelected(String day) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(mainColor),
        border: Border.all(
            color: Color(mainColor)
        ),
      ),
      child: Center(
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COACH INSCRIPTION",
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
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            basicTextField("Prix",priceController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(
                "Jour de disponible",
                textAlign: TextAlign.left,
                style : TextStyle(
                    color: Color(mainColor),
                    fontSize: 18
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                itemDay("Lun", isSelected[0]),
                itemDay("Mar", isSelected[1]),
                itemDay("Mer", isSelected[2]),
                itemDay("Jeu", isSelected[3]),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                itemDay("Ven", isSelected[4]),
                itemDay("Sam", isSelected[5]),
                itemDay("Dim", isSelected[6]),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Equipment à disposition", equipmentOwnedController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextButton (
                  child: Text(
                    "Déjà enregistré ?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            ElevatedButton(
                onPressed: () {
                  // Pass to the next page to sign up
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CoachSignUp4()));
                },
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(mainColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.fromLTRB(60,20,60,20)
                )
            ),
          ],
        ),
      ),
    );
  }
}
