import 'package:flutter/material.dart';

class ItemCalendar {
  TimeOfDay hour;
  DateTime day;

  ItemCalendar(TimeOfDay hour, DateTime day) {
    this.hour = hour;
    this.day = day;
  }

  TimeOfDay getHour() {
    return hour;
  }

  DateTime getDay() {
    return day;
  }
}