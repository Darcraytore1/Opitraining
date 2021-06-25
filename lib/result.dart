import 'package:flutter/material.dart';
import 'package:opitraining/training_plan.dart';
import 'constant.dart';

/// This widget show the result of the user on this training, the time he has
/// take to finish this training, the creator of this training if it's not a
/// basic training

class ResultTraining extends StatefulWidget {

  final String title;
  final int exerciseNumber;
  final Duration totalTime;

  ResultTraining({Key key, this.title, this.exerciseNumber, this.totalTime}) : super (key: key);

  @override
  _ResultTrainingState createState() => _ResultTrainingState();
}

class _ResultTrainingState extends State<ResultTraining> {

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            color: Color(mainColor),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  widget.title + " Complété",
                  style: TextStyle(
                    fontSize: xxl,
                    color: Color(fontColor1)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.exerciseNumber.toString(),
                          style: TextStyle(
                            fontSize: lg,
                            color: Color(fontColor1)
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          "exercices",
                          style: TextStyle(
                            color: Color(fontColor1)
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "05:00",
                          style: TextStyle(
                              fontSize: lg,
                              color: Color(fontColor1)
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          "durée",
                          style: TextStyle(
                              color: Color(fontColor1)
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Créateur : "
              ),
              TextButton(
                onPressed: () {

                },
                child: Text(
                  "Polna246"
                )
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainingPlans(indexTab: 0)),
              );
            },
            child: Text(
              "QUIT",
            ),
            style: ElevatedButton.styleFrom(
                primary: Color(mainColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.width * 0.4)
            ),
          )
        ],
      ),
    );
  }
}
