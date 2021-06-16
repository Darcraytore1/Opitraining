import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'AccountItem.dart';
import 'constant.dart';
import 'my_drawer.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  List<AccountItem> accountItems = [
    AccountItem("Size", "1m80"),
    AccountItem("Weight", "95 kg"),
    AccountItem("Equipment owned", "Dumbbells")
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
          "MY ACCOUNT",
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
              Row (
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Personalize your account",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Follows",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(secondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
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
                      image: AssetImage('images/shogi.jpg'),
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