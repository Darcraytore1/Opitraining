import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opitraining/exercise_runner.dart';
import 'package:opitraining/start_menu_exercise.dart';

import 'constant.dart';

class Rest extends StatefulWidget {

  final int indexExercise;
  final List<Exercise> listExercise;

  Rest({Key key, this.indexExercise, this.listExercise}) : super (key: key);

  @override
  _RestState createState() => _RestState();
}

class _RestState extends State<Rest> with TickerProviderStateMixin{

  AnimationController controller;
  Timer _timer;
  int restTime = 20;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (restTime == 0) {
          setState(() {
            timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExerciseRunner(indexExercise: widget.indexExercise)),
            );
          });
        } else {
          setState(() {
            restTime--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    controller = AnimationController(
      vsync: this,
      reverseDuration: Duration(seconds: restTime),
      duration: Duration(seconds: restTime),
    )..addListener(() {
      setState(() {});
    });
    controller.forward(from: restTime.toDouble());
    controller.reverse();
    super.initState();
  }

  @override
  void dispose() {
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _timer.cancel();
                      Navigator.pop(context);
                    },
                  )
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Text(
              "REST",
              style: TextStyle(
                fontSize: 22,
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
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Text (
              _printDuration(Duration(seconds: restTime)),
              style: TextStyle(
                color: Color(fontColor1),
                fontSize: 22
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      restTime += 20;
                      controller.reset();
                      controller.reverseDuration = Duration(seconds: restTime);
                      controller.forward(from: restTime.toDouble());
                      controller.reverse();
                    });
                  },
                  child: Text(
                    "+20s",
                    style: TextStyle(
                      fontSize: 24,
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
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ElevatedButton(
                  onPressed: () {
                    _timer.cancel();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExerciseRunner(indexExercise: widget.indexExercise, listExercise: widget.listExercise)),
                    );
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                        fontSize: 24,
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
