import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coaching.dart';
import 'package:opitraining/schedule_choice.dart';
import 'package:opitraining/start_menu_exercise.dart';
import 'package:opitraining/training_builder.dart';
import 'Training.dart';
import 'UserTraining.dart';
import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';

/// Show every training that the application offers, and those create by each
/// user, and coachs

class TrainingPlans extends StatefulWidget {
  final int indexTab;

  TrainingPlans({Key key, this.indexTab}) : super (key: key);

  @override
  _TrainingPlansState createState() => _TrainingPlansState();
}

class _TrainingPlansState extends State<TrainingPlans> with SingleTickerProviderStateMixin {

  final db = FirebaseDatabase.instance.reference();
  TabController _tabController;
  List<Training> listTraining = [];
  List<UserTraining> listUserTraining = [];
  List<UserTraining> listCoachTraining = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.indexTab
    );
    _tabController.addListener(_handleTabIndex);

    createListTraining();
  }

  // Take the trainings in the realtime database of firebase and put them in a list
  void createListTraining() {

    List<Training> trainings = [];
    List<Exercise> exercises = [];
    Training training;
    int index = 0;

    // global training
    db.child(opi_pathFirebase).child(opi_cf_configuration).child(opi_cf_trainings).once().then((DataSnapshot data){
      List<dynamic> values = data.value;
      values.forEach((trainingC) async {
        index = 0;
        List<dynamic> exercisesList = trainingC['listExercise'];
        exercisesList.forEach((exercise) {
          exercises.add(Exercise(exercise["video"], exercise["animatedImage"], exercise["title"], exercise["info"], exercise["isRepetition"]));
          index ++;
          if (index == exercisesList.length){
            training = Training(trainingC["title"], trainingC['description'], trainingC['url_image'], exercises);
            exercises = [];
            index = 0;
            setState(() {
              trainings.add(training);
            });
          }
        });
      });
    });


    // coach training
    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).once().then((DataSnapshot data){

      Map<dynamic,dynamic> users = data.value;

      if (users != null) {
        users.forEach((key, value) {
          Map<dynamic,dynamic> trainings = users[key]["userTraining"];

          if (key != uid) {
            if (trainings != null) {
              trainings.forEach((key, value) {
                if (trainings[key]["coaching"]) {
                  exercises = [];
                  trainings[key]["listExercise"].forEach((exercise) {
                    exercises.add(Exercise(exercise["video"], exercise["animatedImage"], exercise["title"], exercise["info"], exercise["isRepetition"]));
                  });
                  listCoachTraining.add(UserTraining(key,trainings[key]['title'], exercises));
                }
              });
            }
          }
        });
      }
    });


    // user training
    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userTraining).once().then((DataSnapshot data){
      Map<dynamic,dynamic> trainings = data.value;

      if (trainings != null) {
        trainings.forEach((key, value) {
          exercises = [];
          trainings[key]["listExercise"].forEach((exercise) {
            exercises.add(Exercise(exercise["video"], exercise["animatedImage"], exercise["title"], exercise["info"], exercise["isRepetition"]));
          });
          listUserTraining.add(UserTraining(key,trainings[key]['title'], exercises));
        });
      }
    });

    listTraining = trainings;
  }

  @override
  void dispose(){
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  Widget itemExercise(Training training) {
    return new Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(training.getUrlImage()),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(0),
                  top: Radius.circular(10),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.85,
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
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.85,
              child : Padding (
                child: Text(
                  training.getTitle(),
                  style: TextStyle(
                    color: Color(fontColor1),
                    fontSize: med,
                  ),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.only(left: 10,bottom: 10),
              ),
            )
          ],
        ),
        Container (
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                  top: Radius.circular(0),
              ),
              color: Color(mainColor),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row (
                  children: [
                    Expanded(
                      child: Padding(
                        child: Text(
                          training.getDescription(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(fontColor1)
                          ),
                        ),
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.015),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScheduleChoice(title: training.title)),
                          );
                        },
                        icon: Icon(Icons.add_alarm)
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.fromLTRB(125,10,125,10)
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StartMenuExercise(listExercise: training.getListExercise(), title: training.getTitle(), urlImage: training.getUrlImage())),
                        );
                      },
                      child: Text(
                        "START",
                        style: TextStyle(
                            color: Color(mainColor),
                            fontSize: med
                        ),
                      )
                  ),
                ),
              ]
          ),
        ),
      ],
    );
  }

  Widget itemUserTraining(UserTraining userTraining, bool isCoaching) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Color(mainColor),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.04),
              Text(
                userTraining.getTitle(),
                style: TextStyle(
                  color: Color(fontColor1),
                  fontSize: xl
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              Text(
                "18 m | 14 exercices",
                style: TextStyle(
                  color: Color(fontColor1)
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.fromLTRB(125,10,125,10)
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StartMenuExercise(listExercise: userTraining.getListExercise(), title: userTraining.getTitle(), urlImage: "images/build_training.jpg")),
                      );
                    },
                    child: Text(
                      "START",
                      style: TextStyle(
                          color: Color(mainColor),
                          fontSize: med
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
        editDeleteBar(isCoaching, userTraining)
      ],
    );
  }

  Widget editDeleteBar(bool isCoaching, UserTraining userTraining) {
    if (!isCoaching) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Row(
          children: [
            Expanded(child: SizedBox()),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScheduleChoice(title: userTraining.title)),
                  );
                },
                icon: Icon(Icons.add_alarm)
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainingBuilder(userTraining: userTraining, isEdit: true)),
                );
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userTraining).child(userTraining.id).remove();
                setState(() {
                  listUserTraining.remove(userTraining);
                });
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
      );
    }
    else return Container();
  }

  Widget _bottomsButtons() {
    return _tabController.index == 0
      ? FloatingActionButton (
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrainingBuilder(isEdit: false)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(mainColor),
      )
    : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(mainColor),
          labelColor: Color(fontColor2),
          unselectedLabelColor: Color(fontColor2).withOpacity(0.4),
          tabs: [
            Tab(
                text: "Entrainement"
            ),
            Tab(
                text: "Coaching"
            )
          ],
        ),
        title: Text(
          "ENTRAINEMENTS",
          style: TextStyle(
              color: Color(fontColor2)
          ),
        ),
        iconTheme: IconThemeData(color: Color(mainColor)),
        backgroundColor: Color(backgroundColor),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: listTraining.length + listUserTraining.length + listCoachTraining.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (listTraining.length - 1 >= index) {
                      return itemExercise(listTraining[index]);
                    } else if (listCoachTraining.length + listTraining.length - 1 >= index) {
                      return itemUserTraining(listCoachTraining[index - listTraining.length], true);
                    } else {
                      return itemUserTraining(listUserTraining[index - (listTraining.length + listCoachTraining.length)], false);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
          Coaching()
        ],
      ),
      floatingActionButton: _bottomsButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}