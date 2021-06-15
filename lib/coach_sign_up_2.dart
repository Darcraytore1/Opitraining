import 'package:flutter/material.dart';

import 'coach_sign_up_3.dart';
import 'constant.dart';

class CoachSignUp2 extends StatefulWidget {
  @override
  _CoachSignUp2State createState() => _CoachSignUp2State();
}

class _CoachSignUp2State extends State<CoachSignUp2> {

  final priceController = TextEditingController();
  final equipmentOwnedController = TextEditingController();

  // The seven days of one week
  final isSelected = [false,false,false,false,false,false,false];

  Widget basicTextField(String placeholder, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Theme(
        data: ThemeData (
          primaryColor: Color(mainColor),
        ),
        child: new TextField(
          controller: controller,
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

  Widget smallTextField(String placeholder, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: Theme(
            data: ThemeData (
              primaryColor: Color(mainColor),
            ),
            child: new TextField(
              controller: controller,
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
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  Widget itemDay(String day, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected[index] = !isSelected[index];
        });
      },
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected[index] ? Color(mainColor) : Colors.white,
          border: Border.all(
              color: Color(mainColor)
          ),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: Center(
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected[index] ? Colors.white : Color(mainColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget circleNotFill() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  Widget circleFill() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }

  Widget signUpCounter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      color: Color(mainColor).withOpacity(0.70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          circleFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signUpCounter(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            smallTextField("Prix",priceController),
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
                itemDay("Lun", 0),
                itemDay("Mar", 1),
                itemDay("Mer", 2),
                itemDay("Jeu", 3),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                itemDay("Ven", 4),
                itemDay("Sam", 5),
                itemDay("Dim", 6),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Equipment à disposition", equipmentOwnedController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
                          child: ElevatedButton(
                              onPressed: () {
                                // Pass to the next page to sign up
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CoachSignUp3()));
                              },
                              child: Text(
                                "CONTINUER",
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
                        )
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
