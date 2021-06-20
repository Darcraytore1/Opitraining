import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'AccountItem.dart';
import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';

class CoachAccount extends StatefulWidget {
  @override
  _CoachAccountState createState() => _CoachAccountState();
}

class _CoachAccountState extends State<CoachAccount> {

  bool isChecked = false;

  final List<String> listDay = ["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"];
  final List<bool> isSelected = [false,false,false,false,false,false,false];
  List<String> listSelectedDay = [];

  List<AccountItem> accountItems = [
    AccountItem("Prénom", "Durant"),
    AccountItem("Nom", "Ronald"),
    AccountItem("Ville", "Paris"),
    AccountItem("Jour de disponible", "Tous les jours de la semaine"),
    AccountItem("Email", ""),
    AccountItem("Téléphone", ""),
    AccountItem("Prix par heure", ""),
    AccountItem("Description", "")
  ];

  List<String> listPathFirebase = [
    "first_name",
    "name",
    "city",
    "availability",
    "email",
    "phone",
    "price",
    "description"
  ];

  List<TextEditingController> listController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final dbMyUser = FirebaseDatabase.instance.reference().child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid);

  @override
  void initState() {

    super.initState();
    // Load content textfield

    dbMyUser.once().then((DataSnapshot data) {
      Map<dynamic,dynamic> users = data.value;

      isChecked = users["is_coach"];

      listController[0].text = users["coach_info"]["first_name"];
      listController[1].text = users["coach_info"]["name"];
      listController[2].text = users["coach_info"]["city"];
      listController[4].text = users["coach_info"]["email"];
      listController[5].text = users["coach_info"]["phone"];
      listController[6].text = users["coach_info"]["price"].toString();
      listController[7].text = users["coach_info"]["description"];

      Map<dynamic,dynamic> dayAvailable = users["coach_info"]["availability"];
      dayAvailable.forEach((key,value) {
        switch (key) {
          case ("Lun"):
            isSelected[0] = value;
            break;

          case ("Mar"):
            isSelected[1] = value;
            break;

          case ("Mer"):
            isSelected[2] = value;
            break;

          case ("Jeu"):
            isSelected[3] = value;
            break;

          case ("Ven"):
            isSelected[4] = value;
            break;

          case ("Sam"):
            isSelected[5] = value;
            break;

          case ("Dim"):
            isSelected[6] = value;
            break;
        }
      });
    });
  }

  Widget itemDay(String day, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected[index] = !isSelected[index];
          dbMyUser.child(opi_dt_coachInfo).child(opi_dt_availability).child(listDay[index]).set(isSelected[index]);
        });
      },
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected[index] ? Color(mainColor) : Color(fontColor1),
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
              color: isSelected[index] ? Color(fontColor1) : Color(mainColor),
            ),
          ),
        ),
      ),
    );
  }


  void daySelected() {
    listSelectedDay = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) listSelectedDay.add(listDay[i]);
    }
  }

  Widget accountItem(String itemName, TextEditingController controller, int index) {
    return Column(
      children: [
        Text(
          itemName,
          style: TextStyle(
              color: Color(mainColor)
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        new Container(
          width: margeWidth(context),
          child: Theme(
            data: ThemeData (
              primaryColor: Color(mainColor),
            ),
            child: new TextField(
              onChanged: (value) {
                dbMyUser.child(opi_dt_coachInfo).child(listPathFirebase[index]).set(
                  value
                );
              },
              textAlign: TextAlign.center,
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center (
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Montrer ton compte aux autres utilisateurs ?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: sm,
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                        fillColor: MaterialStateProperty.all(Color(mainColor)),
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool value) {
                          setState(() {
                            isChecked = value;
                            dbMyUser.child(opi_dt_isCoachP).set(value);
                          });
                          // Here change isCoach to tru
                        }
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/ronald.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                TextButton(
                    onPressed: () {

                    },
                    child: Text(
                        "Change profile photo",
                        style: TextStyle(
                            fontSize: lg
                        )
                    )
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: accountItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 3) {
                        return Column(
                          children: [
                            Container(
                              width: margeWidth(context),
                              child: Text(
                                "Jour de disponible",
                                textAlign: TextAlign.left,
                                style : TextStyle(
                                    color: Color(mainColor),
                                    fontSize: lg
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
                          ],
                        );
                      } else {
                        return accountItem(accountItems[index].name, listController[index], index);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
              ]
          ),
        )
    );
  }
}
