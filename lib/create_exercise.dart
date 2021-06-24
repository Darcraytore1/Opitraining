import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opitraining/new_exercise.dart';

import 'app_bar.dart';
import 'constant.dart';
import 'main.dart';

class CreateExercise extends StatefulWidget {
  @override
  _CreateExerciseState createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {

  TextEditingController controller = new TextEditingController();
  bool isChecked = true;
  File file;
  String url;

  Future pickGalleryMedia(BuildContext context) async {
    final String source = ModalRoute.of(context).settings.arguments;

    final getMedia = source == "image"
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.gallery);
    file = File(media.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "CREER EXERCICE", hasBackArrow: true),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                    hintText: "Nom de l'exercice",
                    hintStyle: TextStyle(
                        color: Color(mainColor),
                        fontSize: lg
                    ),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ListTile(
              title: const Text('Repetition'),
              leading: Radio<bool>(
                value: true,
                groupValue: isChecked,
                onChanged: (bool value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Timer'),
              leading: Radio<bool>(
                value: false,
                groupValue: isChecked,
                onChanged: (bool value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
              onPressed: () async {
                await pickGalleryMedia(context);
                setState(() {});
                Reference ref = FirebaseStorage.instance.ref().child("Video/").child(DateTime.now().toIso8601String());
                UploadTask uploadTask = ref.putFile(file);
                url = await (await uploadTask).ref.getDownloadURL();
              },
              child: Text(
                "UPLOAD VIDEO",
                style: TextStyle(
                    fontSize: lg,
                    color: Color(fontColor1)
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(mainColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.width * 0.2)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ElevatedButton(
              onPressed: () {
                db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userExercise).push().set(
                  {
                    "animatedImage" : url,
                    "info" : 20,
                    "isRepetition": isChecked,
                    "title": controller.text
                  }
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewExercise()),
                );
              },
              child: Text(
                "CREER L'EXERCICE",
                style: TextStyle(
                    fontSize: lg,
                    color: Color(fontColor1)
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(mainColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.width * 0.2)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
