import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opitraining/rest.dart';
import 'package:opitraining/result.dart';
import 'package:opitraining/start_menu_exercise.dart';

import 'Training.dart';
import 'constant.dart';

class ExerciseRunner extends StatefulWidget {

  final int indexExercise;
  final List<Exercise> listExercise;

  ExerciseRunner({Key key, this.indexExercise, this.listExercise}) : super (key: key);

  @override
  _ExerciseRunnerState createState() => _ExerciseRunnerState();
}

class _ExerciseRunnerState extends State<ExerciseRunner> {

  // Must be create with the exercise choose by the user
  /*
  final List<Exercise> listExercise = [
    Exercise(AssetImage("images/jumping-jack.gif"),"JUMPING JACKS",20, false),
    Exercise(AssetImage("images/Incline-Push-Up.gif"), "INCLINE PUSH-UPS", 16, true),
    Exercise(AssetImage("images/push-up-on-knees.gif"), "KNEE PUSH-UPS", 16, true),
    Exercise(AssetImage("images/push_ups.gif"), "PUSH-UPS", 16, true)
  ];
   */

  /*
  final List<Exercise> listExercise = [
    Exercise(Image.network("https://cdn.dribbble.com/users/2931468/screenshots/5720362/jumping-jack.gif"),"JUMPING JACKS",20, false),
    Exercise(Image.network("https://177d01fbswx3jjl1t20gdr8j-wpengine.netdna-ssl.com/wp-content/uploads/2019/06/Incline-Push-Up.gif"), "INCLINE PUSH-UPS", 16, true),
    Exercise(Image.network("https://media.self.com/photos/583c641ca8746f6e65a60c7e/master/w_1600%2Cc_limit/DIAMOND_PUSHUP_MOTIFIED.gif"), "KNEE PUSH-UPS", 16, true),
    Exercise(Image.network("https://thumbs.gfycat.com/GlossySkinnyDuckbillcat-small.gif"), "PUSH-UPS", 16, true)
  ];
   */

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
          color: Colors.black,
          fontSize: 22
        ),
      );
    }
    return Text(
      _printDuration(Duration(seconds: _start)),
      style: TextStyle(
        color: Colors.black,
        fontSize: 22
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
              color: Colors.white,
              fontSize: 18
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
                    fontSize: 22,
                    color: Colors.white
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
                    fontSize: 18
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
