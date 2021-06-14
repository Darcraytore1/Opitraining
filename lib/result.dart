import 'package:flutter/material.dart';
import 'package:opitraining/start_menu_exercise.dart';
import 'package:opitraining/training_plan.dart';
import 'main.dart';

class ResultTraining extends StatefulWidget {
  @override
  _ResultTrainingState createState() => _ResultTrainingState();
}

class _ResultTrainingState extends State<ResultTraining> {
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.02),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: SizedBox()
                        ),
                        Text(
                          "10",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04, left: MediaQuery.of(context).size.width * 0.02),
                          child: Icon(
                            Icons.star_border,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  "Classic Completed",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "4",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          "exercises",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "05:00",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          "duration",
                          style: TextStyle(
                              color: Colors.white
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
                "Creator : "
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {

                },
                child: Text(
                  "ADD TO MY TRAININGS",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(mainColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.07,MediaQuery.of(context).size.height * 0.025,MediaQuery.of(context).size.width * 0.07,MediaQuery.of(context).size.height * 0.025)
                ),
              ),
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
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.07,MediaQuery.of(context).size.height * 0.025,MediaQuery.of(context).size.width * 0.07,MediaQuery.of(context).size.height * 0.025)
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
