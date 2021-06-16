import 'package:flutter/material.dart';

import 'coach_sign_up_4.dart';
import 'constant.dart';

class CoachSignUp3 extends StatefulWidget {

  final List<String> coachInfo;
  final List<String> availability;
  final String price;

  CoachSignUp3({Key key, this.coachInfo, this.availability, this.price}) : super (key: key);

  @override
  _CoachSignUp3State createState() => _CoachSignUp3State();
}

class _CoachSignUp3State extends State<CoachSignUp3> {

  final descriptionController = TextEditingController();
  Widget descriptionTextField(String placeholder, TextEditingController controller) {
    return new Container(
      width: margeWidth(context),
      child: Theme(
        data: ThemeData (
          primaryColor: Color(mainColor),
        ),
        child: new TextField(

          maxLines: 10,
          maxLength: 250,
          controller: controller,
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
      resizeToAvoidBottomInset: false,
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signUpCounter(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              width: margeWidth(context),
              child: Text(
                "Description",
                style: TextStyle(
                  color: Color(mainColor),
                  fontSize: 18
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            descriptionTextField("Description",descriptionController),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CoachSignUp4(coachInfo: widget.coachInfo, availability: widget.availability, price: widget.price, description: descriptionController.text)));
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
