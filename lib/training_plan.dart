import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opitraining/coaching.dart';
import 'package:opitraining/start_menu_exercise.dart';
import 'package:opitraining/training_builder.dart';
import 'Training.dart';
import 'UserTraining.dart';
import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';

const int secondaryColor = 0xFF6090B2;

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
    db.child(pathFirebase).child("trainings").once().then((DataSnapshot data){
      List<dynamic> values = data.value;
      values.forEach((trainingC) async {
        index = 0;
        List<dynamic> exercisesList = trainingC['listExercise'];
        exercisesList.forEach((exercise) {
          exercises.add(Exercise(Image.network(exercise["animatedImage"]), exercise["title"], exercise["info"], exercise["isRepetition"]));
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

    // user training
    db.child(pathFirebase).child("users").child(uid).child("userTraining").once().then((DataSnapshot data){
      List<dynamic> trainings = data.value;

      trainings.forEach((training) {
        exercises = [];
        training["listExercise"].forEach((exercise) {
          exercises.add(Exercise(Image.network(exercise["animatedImage"]), exercise["title"], exercise["info"], exercise["isRepetition"]));
        });
        listUserTraining.add(UserTraining(training["title"], exercises));
      });
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

  List<Widget> listExercises() {

    List<Widget> listExercises = [];

    listTraining.forEach((training) {
      listExercises.add(itemExercise(training));
      listExercises.add(SizedBox(height: MediaQuery.of(context).size.height * 0.02));
    });

    /*
    listExercises.add(itemUserTraining(UserTraining("Strong",[])));
    listExercises.add(SizedBox(height: MediaQuery.of(context).size.height * 0.02));
     */

    return listExercises;
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
                    color: Colors.white,
                    fontSize: 16,
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
                              color: Colors.white
                          ),
                        ),
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.015),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // Add on the schedule
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
                          MaterialPageRoute(builder: (context) => StartMenuExercise(listExercise: training.getListExercise(), training: training)),
                        );
                      },
                      child: Text(
                        "START",
                        style: TextStyle(
                            color: Color(mainColor),
                            fontSize: 16
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

  Widget itemUserTraining(UserTraining userTraining) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Color(secondaryColor).withOpacity(0.35),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.04),
              Text(
                userTraining.getTitle(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
              Text(
                "18 m | 14 exercices"
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.03),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Row(
            children: [
              Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _bottomsButtons() {
    return _tabController.index == 0
      ? FloatingActionButton (
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrainingBuilder()),
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
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.4),
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
              color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(color: Color(mainColor)),
        backgroundColor: Colors.white,
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
                  itemCount: listTraining.length + listUserTraining.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (listTraining.length - 1 >= index) {
                      return itemExercise(listTraining[index]);
                    } else {
                      print(index);
                      return itemUserTraining(listUserTraining[index - listTraining.length]);
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