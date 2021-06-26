import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coach_account.dart';
import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';

/// Information of the user account, for the settings of the applications, and
/// some informations of private friends.

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List<String> accountItems = [];

  List<String> listPathFirebase = [];

  List<TextEditingController> listController = [];

  final db = FirebaseDatabase.instance.reference().child(opi_pathFirebase);
  final dbMyUser = FirebaseDatabase.instance.reference().child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid);

  @override
  void initState() {
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: 0
    );
    _tabController.addListener(_handleTabIndex);

    loadInfo();

    super.initState();
  }


  Future<void> loadInfo() async {
    var dbUserSurvey = db.child(opi_cf_configuration).child(opi_cf_userSurvey);
    var dbPathFirebase = db.child(opi_cf_configuration).child(opi_cf_pathFirebaseUserSurvey);
    var dbUser = db.child(opi_dt_data).child(opi_dt_users).child(uid);

    await dbPathFirebase.once().then((DataSnapshot data) async {
      // List path firebase for coach info
      List<dynamic> listPathFirebase = data.value;

      listPathFirebase.forEach((path) {
        setState(() {
          this.listPathFirebase.add(path);
        });
      });

      await dbUserSurvey.once().then((DataSnapshot data) {

        // List of text field name
        List<dynamic> accountItems = data.value;

        accountItems.forEach((field) {
          setState(() {
            this.accountItems.add(field);
            listController.add(TextEditingController());
          });
        });

        dbUser.once().then((DataSnapshot data) {
          Map<dynamic, dynamic> user = data.value;

          // Initialize value of textField with content of db
          String text = "";

          for (int i = 0; i < this.listPathFirebase.length; i++) {
            if (user["user_info"][this.listPathFirebase[i]] == null) {
              text = "";
            } else {
              text = user["user_info"][this.listPathFirebase[i]].toString();
            }
            setState(() {
              listController[i].text = text;
            });
          }
        });
      });
    });
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
                if (itemName == "Pseudo") {
                  pseudo = value;
                }
                dbMyUser.child(opi_dt_userInfo).child(listPathFirebase[index]).set(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                              imgUserUrl
                            ),
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
                          return accountItem(accountItems[index], listController[index], index);
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