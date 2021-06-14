import 'package:opitraining/start_menu_exercise.dart';

class UserTraining {
  String title;
  List<Exercise> listExercise;

  UserTraining(String title, List<Exercise> listExercise) {
    this.title = title;
    this.listExercise = listExercise;
  }

  String getTitle() {
    return title;
  }

  List<Exercise> getListExercise() {
    return listExercise;
  }
}