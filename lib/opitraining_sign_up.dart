import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:opitraining/training_plan.dart';
import 'constant.dart';

class OpitrainingSignUp extends StatefulWidget {
  @override
  _OpitrainingSignUpState createState() => _OpitrainingSignUpState();
}

class _OpitrainingSignUpState extends State<OpitrainingSignUp> {

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  Widget basicTextField(String placeholder, TextEditingController controller, bool isPassword) {
    return new Container(
      width: MediaQuery.of(context).size.width * 0.80,
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
      appBar: AppBar(
        title: Text(
          "INSCRIPTION",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            basicTextField("Email",emailController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Pseudo", usernameController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Mot de passe", passwordController, true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Confirmation mot de passe", passwordConfirmationController, true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.80,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrainingPlans(indexTab: 0)),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                    usernameController.text = "";
                    passwordController.text = "";
                    passwordConfirmationController.text = "";
                    emailController.text = "";
                  } catch (e) {
                    print(e);
                    usernameController.text = "";
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
          ],
        ),
      ),
    );
  }
}