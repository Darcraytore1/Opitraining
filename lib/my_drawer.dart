import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/new_exercise.dart';
import 'package:opitraining/schedule.dart';
import 'package:opitraining/settings.dart';
import 'constant.dart';
import 'history.dart';
import 'main.dart';
import 'training_plan.dart';
import 'my_account.dart';

class MyDrawer extends StatelessWidget {

  Widget itemDrawer(String itemName, Icon icon, StatefulWidget statefulWidget, BuildContext context) {
    return new InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => statefulWidget),
        );
      },
      child: Container (
        height: MediaQuery.of(context).size.height * 0.088,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: icon,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                  itemName
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBottomDrawer(String itemName, Icon icon, StatefulWidget statefulWidget, BuildContext context) {
    return new InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => statefulWidget),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children : [
          icon,
          Text(
            itemName,
            style: TextStyle(
                color: Color(fontColor1)
            ),
          ),
        ]
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // See better solution
  Widget logOut(String itemName, Icon icon, StatefulWidget statefulWidget, BuildContext context) {
    return new InkWell(
      onTap: () {
        _signOut();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            icon,
            Text(
              itemName,
              style: TextStyle(
                  color: Color(fontColor1)
              ),
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Color(mainColor),
              width: MediaQuery.of(context).size.width * 1,
              // height: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pseudo,
                        style: TextStyle(
                            fontSize: xl,
                            color: Color(fontColor1)
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/logo_opitraining2.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemDrawer(listItem[0], Icon(Icons.accessibility_rounded), TrainingPlans(indexTab: 0), context),
          itemDrawer(listItem[1], Icon(Icons.accessibility_rounded), NewExercise(), context),
          itemDrawer(listItem[2], Icon(Icons.airline_seat_flat_rounded), TrainingPlans(indexTab: 1), context),
          itemDrawer(listItem[3], Icon(Icons.account_circle), MyAccount(), context),
          itemDrawer(listItem[4], Icon(Icons.schedule), Schedule(), context),
          itemDrawer(listItem[5], Icon(Icons.airplanemode_on_rounded), History(), context),
          Expanded(
            flex: 1,
            child: Container(
              color: Color(mainColor),
              width: MediaQuery.of(context).size.width * 1,
              //height: MediaQuery.of(context).size.width * 0.3625,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //itemBottomDrawer(listBottomItems[0], Icon(Icons.share), Contact(), context),
                  itemBottomDrawer(listBottomItems[0], Icon(Icons.settings), Settings(), context),
                  logOut(listBottomItems[1], Icon(Icons.logout), OpitrainingLogin(), context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

