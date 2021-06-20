import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opitraining/rest.dart';
import 'package:opitraining/result.dart';
import 'package:opitraining/start_menu_exercise.dart';

import 'constant.dart';

/// This widget provide the system of exercise helper, we can see a animation
/// of a gif, who show to the user the exercise who must to do, he can go the
/// next exercise or press the pause button

class ExerciseRunner extends StatefulWidget {

  final int indexExercise;
  final List<Exercise> listExercise;

  ExerciseRunner({Key key, this.indexExercise, this.listExercise}) : super (key: key);

  @override
  _ExerciseRunnerState createState() => _ExerciseRunnerState();
}

class _ExerciseRunnerState extends State<ExerciseRunner> {

  bool _isVisible = false;
  bool _isOpaque = false;

  Timer _timer;
  int _start;

  AnimationController _controller;
  Animation<int> _animation;

  bool isRepetition() {
    if (widget.listExercise[widget.indexExercise].getIsRepetition()) return true;
    return false;
  }

  @override
  void initState() {
    if (!isRepetition()) {
      _start = widget.listExercise[widget.indexExercise].getInfo();
      startTimer();
    }
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            if (widget.indexExercise == widget.listExercise.length - 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultTraining()),
              );
            } else {
              int newIndexExercise = widget.indexExercise + 1;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rest(indexExercise: newIndexExercise)),
              );
            }
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget timerOrRepetition() {

    if (isRepetition()) {
      String repetitionString = 'x' + widget.listExercise[widget.indexExercise].getInfo().toString();
      return Text(
        repetitionString,
        style: TextStyle(
          color: Color(fontColor2),
          fontSize: xxl
        ),
      );
    }
    return Text(
      _printDuration(Duration(seconds: _start)),
      style: TextStyle(
        color: Color(fontColor2),
        fontSize: xxl
      ),
    );

  }


  Widget currentExercise(Image animatedImage){
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: animatedImage.image,
          fit: BoxFit.fill
        ),
      ),
    );
  }

  Widget itemPauseOptions(String titleOption) {
    return Container(
      width: margeWidth(context),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center (
        child: Text(
          titleOption,
          style: TextStyle(
              color: Color(fontColor1),
              fontSize: lg
          ),
          textAlign: TextAlign.center,
        ),
      )
    );
  }

  Widget pauseMod() {
    return AnimatedOpacity(
      opacity: _isOpaque ? 1.0: 0.0,
      onEnd: () {
        if(!_isOpaque) {
          setState((){
            _isVisible = false;
          });
        }
      },
      duration: Duration(milliseconds: 350),
      child: Visibility(
        visible: _isVisible,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(mainColor).withOpacity(0.8),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Text(
                "PAUSE",
                style: TextStyle(
                    fontSize: xxl,
                    color: Color(fontColor1)
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              InkWell(
                  onTap: () {

                  },
                  child: itemPauseOptions("QUIT")
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              InkWell(
                  onTap: () {

                  },
                  child: itemPauseOptions("RESTART THIS EXERCISE")
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              InkWell(
                  onTap: () {
                    _isOpaque = !_isOpaque;
                    setState(() {
                      startTimer();
                    });
                  },
                  child: itemPauseOptions("RESUME")
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (!isRepetition()) _timer.cancel();
                          Navigator.pop(context);
                        },
                      )
                  ),
                ),
                currentExercise(widget.listExercise[widget.indexExercise].getAnimatedImage()),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  widget.listExercise[widget.indexExercise].getExerciseTitle(),
                  style: TextStyle(
                    fontSize: lg
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                timerOrRepetition(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                      child: IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () {
                          if (!isRepetition()) _timer.cancel();
                          _isVisible = !_isVisible;
                          _isOpaque = !_isOpaque;
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isRepetition()) _timer.cancel();
                          if (widget.indexExercise == widget.listExercise.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResultTraining()),
                            );
                          } else {
                            int newIndexExercise = widget.indexExercise + 1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Rest(indexExercise: newIndexExercise, listExercise: widget.listExercise)),
                            );
                          }
                        },
                        child: Text(
                            "GO NEXT"
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(mainColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.20,MediaQuery.of(context).size.height * 0.025,MediaQuery.of(context).size.width * 0.20,MediaQuery.of(context).size.height * 0.025)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pauseMod()
        ],
      )
    );
  }
}
