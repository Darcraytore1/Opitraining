import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:opitraining/app_bar.dart';
import 'package:opitraining/training_plan.dart';
import 'constant.dart';
import 'main.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "INSCRIPTION", hasBackArrow: true),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            basicTextField("Email",emailController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Pseudo", pseudoController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Mot de passe", passwordController, true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Confirmation mot de passe", passwordConfirmationController, true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            Container(
                alignment: Alignment.centerRight,
                width: margeWidth(context),
                child: TextButton (
                  child: Text(
                    "Déjà enregistré ?",
                    style: TextStyle(
                      fontSize: 16,
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
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text
                    );

                    uid = userCredential.user.uid;

                    final db = FirebaseDatabase.instance.reference();

                    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).set({
                      "pseudo" : pseudoController.text,
                      "is_coach" : false
                    });

                    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrainingPlans(indexTab: 0)),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      setState(() {
                        error = "Le mot de passe proposé est trop faible";
                      });
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      setState(() {
                        error = "Le compte existe déjà";
                      });
                    }

                  } catch (e) {
                    print(e);
                    pseudoController.text = "";
                    passwordController.text = "";
                    passwordConfirmationController.text = "";
                    emailController.text = "";
                  }
                  /*
                    if(user != null){
                      UserUpdateInfo updateUser = UserUpdateInfo();
                      updateUser.displayName = usernameController.text;
                      user.updateProfile(updateUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrainingPlans(indexTab: 0)),
                      );
                    }
                  } catch (e) {
                    print(e);
                    usernameController.text = "";
                    passwordController.text = "";
                    passwordConfirmationController.text = "";
                    emailController.text = "";
                    // TODO: alertdialog with error
                  }
                   */
                },
                child: Text(
                  "SIGN UP",
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
      ),
    );
  }
}