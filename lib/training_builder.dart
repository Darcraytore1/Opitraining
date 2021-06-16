import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/start_menu_exercise.dart';
import 'package:opitraining/training_plan.dart';

import 'UserTraining.dart';
import 'coaching.dart';
import 'constant.dart';
import 'main.dart';
import 'constant.dart';

class TrainingBuilder extends StatefulWidget {
  @override
  _TrainingBuilderState createState() => _TrainingBuilderState();
}

class _TrainingBuilderState extends State<TrainingBuilder> {

  final db = FirebaseDatabase.instance.reference();

  TextEditingController _searchQueryController = TextEditingController();
  int defaultValue = 20;
  int value = 20;
  bool _isVisible = false;
  bool _setTrainingNameVisible = false;
  bool isRepetition = false;
  Exercise currentExercise;
  bool createTrainingButton = false;

  TextEditingController controller = TextEditingController();

  List<Exercise> listExerciseFiltered = [];
  final List<Exercise> newListExercise = [];

  List<Exercise> listExercise = [];

  @override
  void initState(){
    super.initState();

    List<Exercise> exercises = [];

    db.child(pathFirebase).child(configurationP).child(exercisesP).once().then((DataSnapshot data){
      List<dynamic> values = data.value;

      values.forEach((exercise) {
        setState(() {
          exercises.add(Exercise(exercise["animatedImage"], Image.network(exercise["animatedImage"]), exercise["title"], exercise["info"], exercise["isRepetition"]));
        });
      });

      listExercise.addAll(exercises);
      listExerciseFiltered.addAll(exercises);
    });


  }

  Widget itemExercise(Exercise exercise) {
    return Center (
      child: InkWell(
        onTap: () {
          setState(() {
            _isVisible = true;
            isRepetition = exercise.getIsRepetition();
            currentExercise = exercise;
          });
        },
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
                child: Text(
                  exercise.getExerciseTitle(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox()
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget itemExerciseActive(Exercise exercise) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.03,
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.045,
                  child: IconButton(
                    onPressed: () {
                      print("prout");
                    },
                    icon: Icon(Icons.delete),
                  ),
                )
              ],
            ),
            Expanded(
                child: SizedBox()
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonCreateTraining() {
    if (createTrainingButton) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _setTrainingNameVisible = true;
            });
          },
          child: Text(
            "CREER L'ENTRAINEMENT",
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
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.height * 0.025,MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.height * 0.025)
          ),
        ),
      );
    }
    return Container();
  }

  Widget setTitleSettings(bool isRepetition) {

    String titleSettings;

    if (isRepetition) titleSettings = "Set repetition";
    else titleSettings = "Set duration";

    return Text(
      titleSettings,
      style: TextStyle(
          color: Colors.black,
          fontSize: 20
      ),
    );
  }

  String setTime(int value, bool isRepetition) {
    if (isRepetition) return value.toString();
    else return _printDuration(Duration(seconds: value));
  }

  Widget itemSetNameTraining() {
    return Visibility(
      visible: _setTrainingNameVisible,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0,3),
              )
            ]
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Text(
                "Choisir le nom de l'entrainement",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Theme(
                  data: ThemeData (
                    primaryColor: Colors.black,
                  ),
                  child: new TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder (
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2
                          )
                      ),
                      enabledBorder: OutlineInputBorder (
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _setTrainingNameVisible = false;
                        });
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04, left: MediaQuery.of(context).size.width * 0.04),
                    child: TextButton(
                        onPressed: () {

                          // Add training to the db

                          List<dynamic> jsonListExercise = [];

                          newListExercise.forEach((exercise) {
                            jsonListExercise.add(exercise.json());
                          });

                          db.child(pathFirebase).child(dataP).child(usersP).child(uid).child(userTrainingP).push().set(<String,dynamic>{
                            'title': controller.text,
                            'listExercise': jsonListExercise
                          });


                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TrainingPlans(indexTab: 0)),
                          );

                        },
                        child: Text(
                          "SET",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemSettingExercises(bool isRepetition, Exercise exercise) {
    return Visibility(
      visible: _isVisible,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0,3),
                )
              ]
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              setTitleSettings(isRepetition),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (isRepetition) value --;
                          else value -= 5;
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)
                  ),
                  SizedBox(width:  MediaQuery.of(context).size.width * 0.05),
                  Text(
                    setTime(value, isRepetition),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36
                    ),
                  ),
                  SizedBox(width:  MediaQuery.of(context).size.width * 0.05),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (isRepetition) value ++;
                          else value += 5;
                        });
                      },
                      icon: Icon(Icons.arrow_forward_ios_sharp)
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = false;
                          value = defaultValue;
                        });
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04, left: MediaQuery.of(context).size.width * 0.04),
                    child: TextButton(
                      onPressed: () {
                        newListExercise.add(Exercise(exercise.url, exercise.getAnimatedImage(), exercise.exerciseTitle, value, exercise.getIsRepetition()));
                        _isVisible = false;
                        value = defaultValue;
                        createTrainingButton = true;
                        setState(() {

                        });
                      },
                      child: Text(
                        "SET",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // For filter exercise

  void filterSearchResults(String query) {

    List<Exercise> dummySearchList = [];
    dummySearchList.addAll(listExercise);

    if(query.isNotEmpty) {
      print(dummySearchList.toString());
      List<Exercise> dummyListData = [];
      dummySearchList.forEach((item) {
        print(item.getExerciseTitle());
        if(item.getExerciseTitle().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        listExerciseFiltered.clear();
        listExerciseFiltered.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        listExerciseFiltered.clear();
        listExerciseFiltered.addAll(listExercise);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TRAINING BUILDER",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Stack(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                      minHeight: 0,
                      maxHeight: MediaQuery.of(context).size.height * 0.2
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: newListExercise.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemExerciseActive(newListExercise[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ),
                ),
              ),
              itemSetNameTraining()
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          buttonCreateTraining(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Padding(
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: _searchQueryController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                fillColor: Color(searchColor).withOpacity(0.35),
                filled: true,
                focusedBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                  )
                ),
                enabledBorder: OutlineInputBorder (
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                  )
                ),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18
                )
              ),
            ),
            padding: EdgeInsets.only(left: 40,right: 40),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Expanded(
            child: Stack(
              children: [
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: listExerciseFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemExercise(listExerciseFiltered[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: itemSettingExercises(isRepetition, currentExercise),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
