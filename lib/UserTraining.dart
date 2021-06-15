import 'package:opitraining/start_menu_exercise.dart';

class UserTraining {

  String id;
  String title;
  List<Exercise> listExercise;

  UserTraining(String id, String title, List<Exercise> listExercise) {
    this.id = id;
    this.title = title;
    this.listExercise = listExercise;
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
}