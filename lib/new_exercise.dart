import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:opitraining/app_bar.dart';
import 'package:opitraining/create_exercise.dart';
import 'package:opitraining/start_menu_exercise.dart';
import 'package:video_player/video_player.dart';

import 'constant.dart';
import 'main.dart';
import 'my_drawer.dart';


/// This widget must provide the possibility to add new Exercise to a user

class NewExercise extends StatefulWidget {
  @override
  _NewExerciseState createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {

  List<Exercise> listUserExercise = [];
  List<Exercise> listUserExerciseFiltered = [];
  List<VideoPlayerController> listController = [];
  List<Future<void>> _initializeVideoPlayerFuture = [];
  TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState(){
    super.initState();

    List<Exercise> exercises = [];

    db.child(opi_pathFirebase).child(opi_dt_data).child(opi_dt_users).child(uid).child(opi_dt_userExercise).once().then((DataSnapshot data){
      List<dynamic> values = data.value;

      values.forEach((exercise) {
        setState(() {
          exercises.add(Exercise(exercise["animatedImage"], exercise["title"], exercise["info"], exercise["isRepetition"]));
        });
        listController.add(VideoPlayerController.network(
          exercise["animatedImage"],
        ));
      });

      listController.forEach((controller) {
        _initializeVideoPlayerFuture.add(controller.initialize());
        controller.setVolume(0);
        controller.play();
        controller.setLooping(true);
      });

      listUserExercise.addAll(exercises);
      listUserExerciseFiltered.addAll(exercises);
    });
  }

  Widget itemExercise(Exercise exercise, VideoPlayerController controller, Future<void> init) {
    return Center (
      child: Container(
        width: MediaQuery.of(context).size.width*0.85,
        height: MediaQuery.of(context).size.height*0.14,
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
                child: FutureBuilder(
                  future: init,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return Center(child: CircularProgressIndicator());
                    }
                  },
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
                    fontSize: med,
                    color: Colors.black
                ),
              ),
            ),
            Expanded(
                child: SizedBox()
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.edit)
                ),
                IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.delete)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void filterSearchResults(String query) {

    List<Exercise> dummySearchList = [];
    dummySearchList.addAll(listUserExercise);

    if(query.isNotEmpty) {
      List<Exercise> dummyListData = [];
      dummySearchList.forEach((item) {
        if(item.getExerciseTitle().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        listUserExerciseFiltered.clear();
        listUserExerciseFiltered.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        listUserExerciseFiltered.clear();
        listUserExerciseFiltered.addAll(listUserExercise);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "CREER EXERCICE", hasBackArrow: false),
      drawer: MyDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Padding(
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: _searchQueryController,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    fillColor: Color(tertiaryColor).withOpacity(0.35),
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
                        fontSize: lg
                    )
                ),
              ),
              padding: EdgeInsets.only(left: 40,right: 40),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: listUserExerciseFiltered.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemExercise(listUserExerciseFiltered[index], listController[index], _initializeVideoPlayerFuture[index]);
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ),
            ),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateExercise()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(mainColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
