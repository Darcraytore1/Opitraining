import 'package:flutter/material.dart';

// Color of my application

const int mainColor = 0xFF5D5FEF;


// Path firebase config

const String opi_pathFirebase = "mobile_ALBISSON_DAMIEN";

const String opi_cf_configurationP = "configuration";
const String opi_cf_drawerMenuP = "drawerMenu";
const String opi_cf_itemsP = "items";
const String opi_cf_bottomItemsP = "bottomItems";
const String opi_cf_trainingsP = "trainings";
const String opi_cf_exercisesP = "exercises";


// Path firebase data

const String opi_dt_dataP = "data";
const String opi_dt_usersP = "users";
const String opi_dt_userTrainingP = "userTraining";
const String opi_dt_coachsP = "coachs";
const String opi_dt_isCoachP = "is_coach";
const String opi_dt_coachInfo = "coach_info";
const String opi_dt_firstName = "first_name";
const String opi_dt_availability = "availability";


// Marge

double margeWidth(context) {
  return MediaQuery.of(context).size.width * 0.80;
}

double spaceHeight(context) {
  return MediaQuery.of(context).size.height * 0.80;
}