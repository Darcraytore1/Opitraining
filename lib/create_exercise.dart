import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opitraining/new_exercise.dart';
import 'package:opitraining/start_menu_exercise.dart';

import 'app_bar.dart';
import 'constant.dart';
import 'main.dart';

class CreateExercise extends StatefulWidget {

  final Exercise exercise;

  CreateExercise({Key key, this.exercise}) : super (key: key);

  @override
  _CreateExerciseState createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {

  TextEditingController controller = new TextEditingController();
  bool isChecked = true;
  File file;
  String urlVideo;
  String urlImage;
  double _progressImage = 0;
  double _progressVideo = 0;

  final _formKey = GlobalKey<FormState>();
  bool isEdit = false;
  String buttonTextCreateEdit = "CREER L'EXERCICE";

  @override
  void initState() {
    
    // Edit exercise
    if (widget.exercise != null) {
      controller.text = widget.exercise.exerciseTitle;
      if (widget.exercise.isRepetition) isChecked = true;
      else isChecked = false;
      urlVideo = widget.exercise.urlVideo;
      urlImage = widget.exercise.urlImage;
      isEdit = true;
      buttonTextCreateEdit = "MODIFIER L'EXERCICE";
    }
    super.initState();
  }

  Future pickVideoGalleryMedia(BuildContext context) async {
    final String source = ModalRoute.of(context).settings.arguments;

    final getMedia = source == "image"
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.gallery);
    file = File(media.path);
  }

  Future pickImageGalleryMedia(BuildContext context) async {
    final String source = ModalRoute.of(context).settings.arguments;

    final getMedia = source == "image"
        ? ImagePicker().getVideo
        : ImagePicker().getImage;

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
        child: Form(
          key: _formKey,
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
                  child: new TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez rentrer un titre';
                      }
                      return null;
                    },
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ListTile(
                title: const Text('Exercice avec Repetition'),
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
                title: const Text('Exercice avec Temps'),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ElevatedButton(
                onPressed: () async {
                  await pickImageGalleryMedia(context);
                  setState(() {});
                  Reference ref = FirebaseStorage.instance.ref().child("Image/ExerciseImage/").child(DateTime.now().toIso8601String());
                  UploadTask uploadTask = ref.putFile(file);
                  uploadTask.snapshotEvents.listen((event) {
                    setState(() {
                      _progressImage = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
                    });
                  }).onError((error) {
                    // do something to handle error
                  });
                  urlImage = await (await uploadTask).ref.getDownloadURL();
                },
                child: Text(
                  "UPLOAD IMAGE",
                  style: TextStyle(
                      fontSize: med,
                      color: Color(fontColor1)
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(mainColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.15)
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: margeWidth(context),
                child: LinearProgressIndicator(
                  value: _progressImage,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ElevatedButton(
                onPressed: () async {
                  await pickVideoGalleryMedia(context);
                  setState(() {});
                  Reference ref = FirebaseStorage.instance.ref().child("Video/").child(DateTime.now().toIso8601String());
                  UploadTask uploadTask = ref.putFile(file);
                  uploadTask.snapshotEvents.listen((event) {
                    setState(() {
                      _progressVideo = event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
                    });
                  }).onError((error) {
                    // do something to handle error
                  });
                  urlVideo = await (await uploadTask).ref.getDownloadURL();
                },
                child: Text(
                  "UPLOAD VIDEO",
                  style: TextStyle(
                      fontSize: med,
                      color: Color(fontColor1)
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(mainColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.15)
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: margeWidth(context),
                child: LinearProgressIndicator(
                  value: _progressVideo,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (urlImage == null) urlImage = urlNoImgChoose;
                    if (urlVideo == null) urlVideo = urlNoVideoChoose;
                    if (isEdit) {
                      db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userExercise).child(widget.exercise.id).set(
                          {
                            "animatedImage" : urlImage,
                            "video" : urlVideo,
                            "info" : 20,
                            "isRepetition": isChecked,
                            "title": controller.text
                          }
                      );
                    } else {
                      db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userExercise).push().set(
                          {
                            "animatedImage" : urlImage,
                            "video" : urlVideo,
                            "info" : 20,
                            "isRepetition": isChecked,
                            "title": controller.text
                          }
                      );
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewExercise()),
                    );
                  }
                },
                child: Text(
                  buttonTextCreateEdit,
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
        )
      ),
    );
  }
}
