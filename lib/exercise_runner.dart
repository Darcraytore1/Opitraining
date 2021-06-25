import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opitraining/rest.dart';
import 'package:opitraining/result.dart';
import 'package:opitraining/start_menu_exercise.dart';
import 'package:video_player/video_player.dart';

import 'constant.dart';

/// This widget provide the system of exercise helper, we can see a animation
/// of a gif, who show to the user the exercise who must to do, he can go the
/// next exercise or press the pause button

class ExerciseRunner extends StatefulWidget {

  final int indexExercise;
  final List<Exercise> listExercise;
  final String title;
  final Duration totalTime;

  ExerciseRunner({Key key, this.indexExercise, this.listExercise, this.title, this.totalTime}) : super (key: key);

  @override
  _ExerciseRunnerState createState() => _ExerciseRunnerState();
}

class _ExerciseRunnerState extends State<ExerciseRunner> {

  VideoPlayerController _videController;
  Future<void> _initializeVideoPlayerFuture;

  bool _isVisible = false;
  bool _isOpaque = false;

  Timer _timer;
  int _start;
  Duration totalTime;

  bool isRepetition() {
    if (widget.listExercise[widget.indexExercise].getIsRepetition()) return true;
    return false;
  }

  @override
  void initState() {
    if (!isRepetition()) {
      _start = widget.listExercise[widget.indexExercise].getInfo();
      //totalTime = Duration(seconds: (widget.totalTime.inSeconds + _start));
      startTimer();
    } else {
      //totalTime = Duration(seconds: (widget.totalTime.inSeconds + _start));
    }

    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _videController = VideoPlayerController.network(
      widget.listExercise[widget.indexExercise].urlVideo,
    );

    _initializeVideoPlayerFuture = _videController.initialize();
    _videController.play();
    _videController.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.

    _videController.dispose();
    _timer.cancel();
    super.dispose();
  }


  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            _videController.dispose();
            timer.cancel();
            if (widget.indexExercise == widget.listExercise.length - 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultTraining(title: widget.title, exerciseNumber: widget.listExercise.length, totalTime: totalTime)),
              );
            } else {
              int newIndexExercise = widget.indexExercise + 1;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rest(indexExercise: newIndexExercise, totalTime: totalTime)),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child : FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the video.
                        return AspectRatio(
                          aspectRatio: _videController.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: VideoPlayer(_videController),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
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
                          _videController.dispose();
                          if (!isRepetition()) _timer.cancel();
                          if (widget.indexExercise == widget.listExercise.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResultTraining(title: widget.title, exerciseNumber: widget.listExercise.length, totalTime: totalTime)),
                            );
                          } else {
                            int newIndexExercise = widget.indexExercise + 1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Rest(indexExercise: newIndexExercise, listExercise: widget.listExercise, title: widget.title, totalTime: totalTime)),
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
