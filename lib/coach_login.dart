import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coach_sign_up.dart';

import 'coach_account.dart';
import 'constant.dart';

class CoachLogin extends StatefulWidget {
  @override
  _CoachLoginState createState() => _CoachLoginState();
}

class _CoachLoginState extends State<CoachLogin> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String error = "";

  Widget basicTextField(String placeholder, TextEditingController controller, bool isPassword) {
    return new TextField(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
          Text(
            "COACH CONNEXION",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.80,
                  child: Text(
                    error,
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.015),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.80,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Color(mainColor),
                    ),
                    child: basicTextField("Email", emailController, false),
                  ),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.028),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.80,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Color(mainColor),
                    ),
                    child: basicTextField(
                        "Mot de passe", passwordController, true),
                  ),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.80,
                  child: Text(
                    "Mot de passe oublié",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoachAccount()));
                  },
                  child: Text(
                    "CONNEXION",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(mainColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(vertical: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03, horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.15)
                  ),
                ),
                TextButton(
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                      color: Color(mainColor),
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    error = "";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoachSignUp()),
                    );
                  },
                )
              ],
            )
        )
    );
  }
}
