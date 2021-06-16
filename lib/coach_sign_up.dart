import 'package:flutter/material.dart';
import 'package:opitraining/coach_sign_up_2.dart';

import 'constant.dart';

class CoachSignUp extends StatefulWidget {
  @override
  _CoachSignUpState createState() => _CoachSignUpState();
}

class _CoachSignUpState extends State<CoachSignUp> {

  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

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

  Widget signUpCounter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      color: Color(mainColor).withOpacity(0.70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          circleNotFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
          circleNotFill()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signUpCounter(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            basicTextField("Prénom",firstNameController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Nom",nameController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Téléphone", phoneController, false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            basicTextField("Ville", cityController, false),
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
                            // Pass to the next page to sign up
                            List<String> coachInfo = [firstNameController.text, nameController.text, phoneController.text, cityController.text];
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CoachSignUp2(coachInfo: coachInfo)));
                          },
                          child: Text(
                            "CONTINUER",
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
