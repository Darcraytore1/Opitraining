import 'package:flutter/material.dart';

import 'constant.dart';

class CoachSignUp4 extends StatefulWidget {
  @override
  _CoachSignUp4State createState() => _CoachSignUp4State();
}

class _CoachSignUp4State extends State<CoachSignUp4> {

  final loginController = TextEditingController();
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
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signUpCounter(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            basicTextField("Nom d'utilisateur",loginController, false),
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
                                // Here create coach account
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
