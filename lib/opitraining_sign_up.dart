import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:opitraining/app_bar.dart';
import 'package:opitraining/training_plan.dart';
import 'constant.dart';
import 'main.dart';
import 'my_text_fields.dart';

/// This widget provide to the user a possibility to sign up to the application
/// for use her

class OpitrainingSignUp extends StatefulWidget {
  @override
  _OpitrainingSignUpState createState() => _OpitrainingSignUpState();
}

class _OpitrainingSignUpState extends State<OpitrainingSignUp> {

  final emailController = TextEditingController();
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  String error = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: opiStrTitleSignUpPage, hasBackArrow: true),
      body: Center (
        child: Form(
          key: _formKey,
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyTextFields(placeholder: "Email",controller: emailController, isPassword: false),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              MyTextFields(placeholder: "Pseudo",controller: pseudoController, isPassword: false),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              MyTextFields(placeholder: "Mot de passe",controller: passwordController, isPassword: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              MyTextFields(placeholder: "Confirmation mot de passe",controller: passwordConfirmationController, isPassword: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.008),
              Container(
                  alignment: Alignment.centerRight,
                  width: margeWidth(context),
                  child: TextButton (
                    child: Text(
                      "Déjà enregistré ?",
                      style: TextStyle(
                          fontSize: med,
                          color: Colors.black
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance.createUserWithEmailAndPassword(
                            email: emailController.text.replaceAll(new RegExp(r"\s+"), ""),
                            password: passwordController.text.replaceAll(new RegExp(r"\s+"), "")
                        );

                        print("plouf");

                        uid = userCredential.user.uid;
                        pseudo = pseudoController.text;
                        advisedTime = 20;

                        final db = FirebaseDatabase.instance.reference();

                        db.child(opi_pathFirebase).child(opi_dt_data).child(
                            opi_dt_users).child(uid).set({
                          "user_info": {
                            "pseudo": pseudoController.text,
                            "restTime": 20
                          },
                          "is_coach": false
                        });

                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text.replaceAll(new RegExp(r"\s+"), ""),
                          password: passwordController.text.replaceAll(new RegExp(r"\s+"), ""),
                        );

                        // Load coach and user image (url link)

                        imgBaseUrl = await FirebaseStorage.instance
                            .ref('Image/UserImage/profile_vide.png')
                            .getDownloadURL();

                        db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).once().then((DataSnapshot data) async {
                          Map<dynamic, dynamic> userInfo = data.value;

                          if (userInfo["coach_info"] != null) imgCoachUrl = userInfo["coach_info"]["image"];
                          imgUserUrl = userInfo["user_info"]["image"];

                          if (imgUserUrl == null) {
                            imgUserUrl = imgBaseUrl;
                          }

                          if (imgCoachUrl == null) {
                            imgCoachUrl = imgBaseUrl;
                          }
                        });

                        // Load img and video for person who don't choose any image or video

                        urlNoImgChoose = await FirebaseStorage.instance
                            .ref('Image/ExerciseImage/no_image.png')
                            .getDownloadURL();

                        urlNoVideoChoose = await FirebaseStorage.instance
                            .ref('Video/no_video.mp4')
                            .getDownloadURL();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainingPlans(indexTab: 0),
                              settings: RouteSettings(name: "/trainingPlan")
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          error = "Le mot de passe proposé est trop faible";
                          setState(() {});
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          error = "Le compte existe déjà";
                          setState(() {});
                        } else if (e.code == "invalid-email") {
                          print('Your email address appears to be malformed..');
                          error = "L'adresse email est mal formé";
                        } else {
                          error = "Une erreur c'est produite";
                        }
                      } catch (e) {
                        print(e);
                        pseudoController.text = "";
                        passwordController.text = "";
                        passwordConfirmationController.text = "";
                        emailController.text = "";
                      }
                    }
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: lg
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Container(
                alignment: Alignment.center,
                width: margeWidth(context),
                child: Text(
                  error,
                  style: TextStyle(
                      color: Colors.red
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}