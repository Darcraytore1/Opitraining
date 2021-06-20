import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coach_info.dart';

import 'Coach.dart';
import 'constant.dart';
import 'main.dart';

class CoachSignUp4 extends StatefulWidget {

  final List<String> coachInfo;
  final List<String> availability;
  final String price;
  final String description;

  CoachSignUp4({Key key, this.coachInfo, this.availability, this.price, this.description}) : super (key: key);

  @override
  _CoachSignUp4State createState() => _CoachSignUp4State();
}

class _CoachSignUp4State extends State<CoachSignUp4> {

  final db = FirebaseDatabase.instance.reference();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  Widget basicTextField(String placeholder, TextEditingController controller, bool isPassword) {
    return new Container(
      width: margeWidth(context),
      child: Theme(
        data: ThemeData (
          primaryColor: Color(mainColor),
        ),
        child: new TextField(
          controller: controller,
          obscureText: isPassword,
          enableSuggestions: !isPassword,
          autocorrect: !isPassword,
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
              hintText: placeholder,
              hintStyle: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18
              )
          ),
        ),
      ),
    );
  }

  Widget circleNotFill() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  Widget circleFill() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }

  Widget signUpCounter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      color: Color(mainColor).withOpacity(0.70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          circleFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signUpCounter(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            basicTextField("Email",emailController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Mot de passe", passwordController, true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Confirmation de mot de passe", passwordConfirmationController, true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
                          child: ElevatedButton(
                              onPressed: () {

                                Coach coach = Coach(widget.coachInfo[0], widget.coachInfo[1], widget.coachInfo[3], int.parse(widget.price), widget.availability, widget.coachInfo[2], widget.description, emailController.text);

                                // Here create a account with the system of authentication of firebase

                                db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).once().then((DataSnapshot data) async {
                                  Map<dynamic,dynamic> user = data.value;

                                  if (user == null) {

                                    try {
                                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text
                                      );

                                      final db = FirebaseDatabase.instance.reference();

                                      db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).set({
                                        "pseudo" : emailController.text
                                      });

                                      db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_coachs).child(userCredential.user.uid).set(coach.json());

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CoachInfo()),
                                      );

                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        print('The password provided is too weak.');
                                      } else if (e.code == 'email-already-in-use') {
                                        print(
                                            'The account already exists for that email.');
                                      }
                                      passwordController.text = "";
                                      passwordConfirmationController.text = "";
                                      emailController.text = "";
                                    } catch (e) {
                                      print(e);
                                      passwordController.text = "";
                                      passwordConfirmationController.text = "";
                                      emailController.text = "";
                                    }

                                  } else if (user["is_coach"] == false) {

                                    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_coachs).child(uid).set(coach.json());
                                    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_isCoachP).set(true);
                                  } else {
                                    print("Ce compte existe déjà");
                                  }
                                });

                                //Navigator.push(context, MaterialPageRoute(builder: (context) => CoachSignUp4()));
                              },
                              child: Text(
                                "S'ENREGISTRER",
                                style: TextStyle(
                                    fontSize: 18
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
                        )
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
