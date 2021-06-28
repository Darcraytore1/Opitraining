import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';
import 'package:opitraining/exercise_runner.dart';
import 'package:opitraining/my_drawer.dart';

import 'constant.dart';

class Exercise {

  String id;
  String urlVideo;
  String urlImage;
  String exerciseTitle;
  int info;
  bool isRepetition;

  Exercise(String id, String urlVideo, String urlImage, String exerciseTitle, int info, bool isRepetition ) {
    this.id = id;
    this.urlVideo = urlVideo;
    this.urlImage = urlImage;
    this.exerciseTitle = exerciseTitle;
    this.info = info;
    this.isRepetition = isRepetition;
  }

  /*
  AssetImage getAnimatedImage() {
    return animatedImage;
  }
   */

  String getId() {
    return id;
  }

  String getUrlVideo() {
    return urlVideo;
  }

  String getUrlImage() {
    return urlImage;
  }

  String getExerciseTitle() {
    return exerciseTitle;
  }

  int getInfo() {
    return info;
  }

  bool getIsRepetition() {
    return isRepetition;
  }

  void setInfo(int info) {
    this.info = info;
  }

  Map<String,dynamic> json() {
    return {
      "animatedImage": urlImage,
      "video": urlVideo,
      "title": exerciseTitle,
      "info": info,
      "isRepetition": isRepetition
    };
  }
}

/// This widget show each exercise than contain a training

class StartMenuExercise extends StatefulWidget {

  final List<Exercise> listExercise;
  final String title;
  final String urlImage;

  StartMenuExercise({Key key, this.listExercise, this.title, this.urlImage}) : super (key: key);

  @override
  _StartMenuExerciseState createState() => _StartMenuExerciseState();
}

class _StartMenuExerciseState extends State<StartMenuExercise> {

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  
  String formatInfo(Exercise exercise) {
    if (exercise.getIsRepetition()) return "x" + exercise.getInfo().toString();
    return _printDuration(Duration(seconds: exercise.getInfo()));
  }

  Widget itemExercise(Exercise exercise) {
    return Center (
      child: Container(
        width: MediaQuery.of(context).size.width*0.85,
        height: MediaQuery.of(context).size.height*0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black
          )
        ),
        child: Row(
          children: [
            // gif
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.10,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(exercise.urlImage),
                    fit: BoxFit.scaleDown
                  )
                )
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox()
            ),
            // info exercise
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      exercise.getExerciseTitle(),
                      style: TextStyle(
                          fontSize: med,
                          color: Color(fontColor2)
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01),
                    Text(
                      formatInfo(exercise),
                      style: TextStyle(
                          fontSize: med,
                          color: Color(fontColor2)
                      ),
                    )
                  ]
              ),
            ),
            Expanded(
                child: SizedBox()
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "EXERCICES", hasBackArrow: false),
      drawer: MyDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.urlImage),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.center,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0),
                        Colors.black,
                      ],
                      stops: [
                        0.0,
                        1.0
                      ]
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20, bottom: MediaQuery.of(context).size.height * 0.03),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: lg,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
            child: Text(
              "6 mins | 4 workouts"
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: widget.listExercise.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemExercise(widget.listExercise[index]);
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseRunner(indexExercise: 0, listExercise: widget.listExercise, title: widget.title, totalTime: 0)),
                  );
                },
                child: Text(
                  "START",
                  style: TextStyle(
                    fontSize: lg,
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(mainColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.35,MediaQuery.of(context).size.height * 0.025,MediaQuery.of(context).size.width * 0.35,MediaQuery.of(context).size.height * 0.025)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
