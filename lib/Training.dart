import 'package:opitraining/start_menu_exercise.dart';

class Training {
  String title;
  String description;
  String urlImage;
  List<Exercise> listExercise;

  Training(String title, String description, String urlImage, List<Exercise> listExercise) {
    this.title = title;
    this.description = description;
    this.urlImage = urlImage;
    this.listExercise = listExercise;
  }

  /*
  factory Training.fromJson(dynamic value) {
    return Training(value['title'], value['description'], value['url_image']);
  }
   */

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  String getUrlImage() {
    return urlImage;
  }

  List<Exercise> getListExercise() {
    return listExercise;
  }
}