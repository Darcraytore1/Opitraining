import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'AccountItem.dart';
import 'constant.dart';
import 'my_drawer.dart';

class CoachAccount extends StatefulWidget {
  @override
  _CoachAccountState createState() => _CoachAccountState();
}

class _CoachAccountState extends State<CoachAccount> {

  List<AccountItem> accountItems = [
    AccountItem("Nom", "Durant"),
    AccountItem("Prénom", "Ronald"),
    AccountItem("Ville", "Paris"),
    AccountItem("Jour de disponible", "Tous les jours de la semaine")
  ];

  final db = FirebaseDatabase.instance.reference();

  Widget accountItem(String itemName, String value) {
    return Column(
      children: [
        Text(
          itemName,
          style: TextStyle(
              color: Color(mainColor)
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        Container (
          width: margeWidth(context),
          child: OutlinedButton(
              onPressed: () {

              },
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),
              ),

              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              )
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "COMPTE DE COACH",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          iconTheme: IconThemeData(color: Color(mainColor)),
          backgroundColor: Colors.white,
        ),
        drawer: MyDrawer(),
        body: Center (
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personnalise ton compte",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
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
                            fontSize: 18
                        )
                    )
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: accountItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return accountItem(accountItems[index].name, accountItems[index].value);
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ),
                ),
              ]
          ),
        )
    );
  }
}
