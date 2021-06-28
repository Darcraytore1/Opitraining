import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opitraining/exercise_runner.dart';
import 'package:opitraining/start_menu_exercise.dart';

import 'constant.dart';
import 'main.dart';

/// This widget provide a rest time to the user between each exercise, with
/// a circular bar progress to see the time who stay to the user before to pass
/// to another exercise, he can skip that rest or increase that rest of 20s in 20s

class Rest extends StatefulWidget {

  final int indexExercise;
  final List<Exercise> listExercise;
  final String title;
  final int totalTime;

  Rest({Key key, this.indexExercise, this.listExercise, this.title, this.totalTime}) : super (key: key);

  @override
  _RestState createState() => _RestState();
}

class _RestState extends State<Rest> with TickerProviderStateMixin{

  AnimationController controller;
  Timer _timer;
  int restTime = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          restTime++;
          if (restTime % widget.listExercise[widget.indexExercise - 1].restTime == 0) {
            controller.reset();
            controller.forward();
          }
        });
      },
    );
  }

  @override
  void initState() {
    startTimer();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.listExercise[widget.indexExercise - 1].restTime),
    )..addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(mainColor),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Text(
              "REPOS " + "(" + _printDuration(Duration(seconds: widget.listExercise[widget.indexExercise - 1].restTime)) + ")",
              style: TextStyle(
                fontSize: xxl,
                color: Color(fontColor1)
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: 120,
              height: 120,
              child: new CircularProgressIndicator(
                value: controller.value,
                color: Colors.white,
                semanticsLabel: "eae",
                strokeWidth: 8,
              )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Text (
              _printDuration(Duration(seconds: restTime)),
              style: TextStyle(
                color: Color(fontColor1),
                fontSize: xxl
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExerciseRunner(indexExercise: widget.indexExercise, listExercise: widget.listExercise, title: widget.title, totalTime: widget.totalTime)),
                    );
                  },
                  child: Text(
                    "PASSER",
                    style: TextStyle(
                        fontSize: xxl,
                        color: Color(fontColor2)
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.07,MediaQuery.of(context).size.height * 0.015,MediaQuery.of(context).size.width * 0.07,MediaQuery.of(context).size.height * 0.015)
                  ),
                ),
              ],

            )
          ],
        ),
      ),
    );
  }
}
