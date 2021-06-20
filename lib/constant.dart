import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// Path firebase config

const String opi_pathFirebase = "mobile_ALBISSON_DAMIEN";

const String opi_cf_configuration = "configuration";
const String opi_cf_drawerMenu = "drawerMenu";
const String opi_cf_items = "items";
const String opi_cf_bottomItems = "bottomItems";
const String opi_cf_trainings = "trainings";
const String opi_cf_exercises = "exercises";
const String opi_cf_theme = "theme";


// Path firebase data

const String opi_dt_data = "data";
const String opi_dt_users = "users";
const String opi_dt_userTraining = "userTraining";
const String opi_dt_coachs = "coachs";
const String opi_dt_isCoachP = "is_coach";
const String opi_dt_coachInfo = "coach_info";
const String opi_dt_firstName = "first_name";
const String opi_dt_availability = "availability";


// Path of the theme of the application with all infos like colors, font size ...

final db = FirebaseDatabase.instance.reference();
final themeRef = db.child(opi_pathFirebase).child(opi_cf_configuration).child(opi_cf_theme);

// Colors statement

int backgroundColor;
int mainColor;
int secondaryColor;
int tertiaryColor;
int fontColor1;
int fontColor2;

// Font size statement

double xsm;
double med;
double lg;
double sm;
double xl;
double xxl;
double builderTime;

// I load the theme of the application from the firebase db

void initTheme() {
  themeRef.once().then((DataSnapshot data) {

    Map<dynamic,dynamic> theme = data.value;

    Map<dynamic,dynamic> colors = theme["Theme"]["colors"];

    // Color of the application

    backgroundColor = int.parse(colors["backgroundColor"]);
    mainColor = int.parse(colors["primaryColor"]);
    secondaryColor = int.parse(colors["secondaryColor"]);
    tertiaryColor = int.parse(colors["tertiaryColor"]);
    fontColor1 = int.parse(colors["fontColor1"]);
    fontColor2 = int.parse(colors["fontColor2"]);

    // Font size of the application

    Map<dynamic,dynamic> fontSizes = theme["Theme"]["fontSizes"];

    xsm = fontSizes["xsm"].toDouble();
    sm = fontSizes["sm"].toDouble();
    med = fontSizes["med"].toDouble();
    lg = fontSizes["lg"].toDouble();
    xl = fontSizes["xl"].toDouble();
    xxl = fontSizes["xxl"].toDouble();
    builderTime = fontSizes["builder_time"].toDouble();

  });
}

// Marge

double margeWidth(context) {
  return MediaQuery.of(context).size.width * 0.80;
}

double spaceHeight(context) {
  return MediaQuery.of(context).size.height * 0.80;
}