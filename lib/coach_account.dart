import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'constant.dart';
import 'main.dart';

/// This widget permit to personalize your coach account for each person on the
/// application can see your profile and contact you, if they want to have some
/// "lessons" of you part.

class CoachAccount extends StatefulWidget {
  @override
  _CoachAccountState createState() => _CoachAccountState();
}

class _CoachAccountState extends State<CoachAccount> {

  File file;

  bool isChecked = false;

  final List<String> listDay = ["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"];
  final List<bool> isSelected = [false,false,false,false,false,false,false];
  List<String> listSelectedDay = [];

  List<String> accountItems = [];

  List<String> listPathFirebase = [];

  List<TextEditingController> listController = [];

  final db = FirebaseDatabase.instance.reference().child(opi_pathFirebase);
  final dbMyUser = FirebaseDatabase.instance.reference().child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid);

  @override
  void initState() {

    // Load content textfield

    db.once().then((DataSnapshot data) {

      Map<dynamic,dynamic> ref = data.value;

      // List of text field name
      List<dynamic> accountItems = ref[opi_cf_configuration][opi_cf_coachSurvey];

      accountItems.forEach((field) {
        setState(() {
          this.accountItems.add(field);
        });
      });

      // List path firebase for coach info
      List<dynamic> listPathFirebase =  ref[opi_cf_configuration][opi_cf_pathFirebaseCoachSurvey];

      listPathFirebase.forEach((path) {
        setState(() {
          this.listPathFirebase.add(path);
        });
      });

      Map<dynamic,dynamic> user = ref[opi_dt_data][opi_dt_users][uid];

      isChecked = user["is_coach"];

      // Initialize value of textField with content of db
      String text = "";

      this.listPathFirebase.forEach((element) {
        this.listController.add(TextEditingController());
      });
      setState(() {});

      if (user["coach_info"] != null) {
        for (int i = 0; i < this.listPathFirebase.length; i++) {
          if (user["coach_info"][this.listPathFirebase[i]] == null) {
            text = "";
          } else {
            text = user["coach_info"][this.listPathFirebase[i]].toString();
          }
          setState(() {
            listController[i].text = text;
          });
        }

        Map<dynamic, dynamic> dayAvailable = user["coach_info"]["availability"];
        dayAvailable.forEach((key, value) {
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
      }
    });

    super.initState();
  }

  Future pickImageGalleryMedia(BuildContext context) async {
    final String source = ModalRoute.of(context).settings.arguments;

    final getMedia = source == "image"
        ? ImagePicker().getVideo
        : ImagePicker().getImage;

    final media = await getMedia(source: ImageSource.gallery);
    file = File(media.path);
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
                          bool isCompleted = true;

                          listController.forEach((controller) {
                            if (controller.text == "" || controller.text == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Toutes les informations ne sont pas remplis"
                                    ),
                                    action: SnackBarAction(
                                      label: "X",
                                      onPressed: () {},
                                    ),
                                  )
                              );
                              isCompleted = false;
                            }
                          });

                          if (isCompleted) {
                            isChecked = value;
                            dbMyUser.child(opi_dt_isCoachP).set(value);
                          }

                          setState(() {});
                          // Here change isCoach to tru
                        }
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 120,
                  height: 120,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        image: NetworkImage(
                            imgCoachUrl,
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
                TextButton(
                    onPressed: () async {
                      await pickImageGalleryMedia(context);
                      setState(() {});
                      Reference ref = FirebaseStorage.instance.ref().child("Image/UserImage/").child(DateTime.now().toIso8601String());
                      UploadTask uploadTask = ref.putFile(file);
                      imgCoachUrl = await (await uploadTask).ref.getDownloadURL();
                      dbMyUser.child(opi_dt_coachInfo).child("image").set(
                        imgCoachUrl
                      );
                      setState(() {});
                    },
                    child: Text(
                      "Changer la photo de profile",
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
                        return accountItem(accountItems[index], listController[index], index);
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
