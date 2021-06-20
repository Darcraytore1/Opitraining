import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coach_account.dart';
import 'AccountItem.dart';
import 'constant.dart';
import 'my_drawer.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List<AccountItem> accountItems = [
    AccountItem("Taille", "1m80"),
    AccountItem("Poids", "95 kg"),
    AccountItem("Equipment à disposition", "Dumbbells")
  ];

  List<TextEditingController> listController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final db = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: 0
    );
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose(){
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  Widget accountItem(String itemName, TextEditingController controller) {
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
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(mainColor),
          labelColor: Color(fontColor2),
          unselectedLabelColor: Color(fontColor2).withOpacity(0.4),
          tabs: [
            Tab(
                text: "Perso"
            ),
            Tab(
                text: "Coach"
            )
          ],
        ),
        title: Text(
          "MON COMPTE",
          style: TextStyle(
            color: Color(fontColor2)
          ),
        ),
        iconTheme: IconThemeData(color: Color(mainColor)),
        backgroundColor: Color(backgroundColor),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center (
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Personnalise ton compte",
                        style: TextStyle(
                          fontSize: lg,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          "Follows",
                          style: TextStyle(
                              fontSize: lg,
                              color: Color(fontColor2)
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
                          "Changer la photo de profil",
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
                        return accountItem(accountItems[index].name, listController[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    ),
                  ),
                ]
            ),
          ),
          CoachAccount()
        ],
      )
    );
  }
}