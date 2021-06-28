import 'package:opitraining/start_menu_exercise.dart';

class UserTraining {

  String id;
  String title;
  List<Exercise> listExercise;
  bool isCoaching;

  UserTraining(String id, String title, List<Exercise> listExercise, bool isCoaching) {
    this.id = id;
    this.title = title;
    this.listExercise = listExercise;
    this.isCoaching = isCoaching;
  }

  String getId() {
    return id;
  }

  String getTitle() {
    return title;
  }

  List<Exercise> getListExercise() {
    return listExercise;
  }

  bool getIsCoaching() {
    return isCoaching;
  }
}