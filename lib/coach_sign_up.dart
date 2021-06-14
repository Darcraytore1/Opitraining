import 'package:flutter/material.dart';
import 'package:opitraining/coach_sign_up_2.dart';

import 'main.dart';

class CoachSignUp extends StatefulWidget {
  @override
  _CoachSignUpState createState() => _CoachSignUpState();
}

class _CoachSignUpState extends State<CoachSignUp> {

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

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
          "COACH INSCRIPTION",
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
            basicTextField("Nom et prénom",fullNameController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Mail", emailController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Téléphone", phoneController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Ville", cityController, false),
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
                onPressed: () {
                  // Pass to the next page to sign up
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CoachSignUp2()));
                },
                child: Text(
                  "NEXT",
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
