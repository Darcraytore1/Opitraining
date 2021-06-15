import 'package:flutter/material.dart';
import 'package:opitraining/exercise_runner.dart';
import 'package:opitraining/my_drawer.dart';

import 'Training.dart';
import 'constant.dart';

class Exercise {
  //AssetImage animatedImage;
  Image animatedImage;
  String exerciseTitle;
  int info;
  bool isRepetition;

  Exercise(Image animatedImage, String exerciseTitle, int info, bool isRepetition ) {
    this.animatedImage = animatedImage;
    this.exerciseTitle = exerciseTitle;
    this.info = info;
    this.isRepetition = isRepetition;
  }

  /*
  AssetImage getAnimatedImage() {
    return animatedImage;
  }

   */

  Image getAnimatedImage() {
    return animatedImage;
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
}

class StartMenuExercise extends StatefulWidget {

  final List<Exercise> listExercise;
  final Training training;

  StartMenuExercise({Key key, this.listExercise, this.training}) : super (key: key);

  @override
  _StartMenuExerciseState createState() => _StartMenuExerciseState();
}

class _StartMenuExerciseState extends State<StartMenuExercise> {

  /*
  final List<Exercise> listExercise = [
    Exercise(AssetImage("images/jumping-jack.gif"),"JUMPING JACKS", 20, false),
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
                      image: exercise.getAnimatedImage().image,
                      fit: BoxFit.fill
                  ),
                ),
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
                          fontSize: 16,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01),
                    Text(
                      formatInfo(exercise),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black
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
      appBar: AppBar(
        title: Text(
          "EXERCICES",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(color: Color(mainColor)),
        backgroundColor: Colors.white,
      ),
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
                      image: AssetImage(widget.training.urlImage),
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
                    widget.training.getTitle(),
                    style: TextStyle(
                        fontSize: 18,
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
                    MaterialPageRoute(builder: (context) => ExerciseRunner(indexExercise: 0, listExercise: widget.listExercise)),
                  );
                },
                child: Text(
                  "START",
                  style: TextStyle(
                    fontSize: 18,
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
