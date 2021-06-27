import 'package:flutter/material.dart';

class ItemCalendar {

  String id;
  TimeOfDay hour;
  DateTime day;
  String title;

  ItemCalendar(String id, TimeOfDay hour, DateTime day, String title) {
    this.id = id;
    this.hour = hour;
    this.day = day;
    this.title = title;
  }

  TimeOfDay getHour() {
    return hour;
  }

  void setHour(TimeOfDay hour) {
    this.hour = hour;
  }

  DateTime getDay() {
    return day;
  }

  String getId() {
    return id;
  }

  String getTitle() {
    return title;
  }

  int compareTo(ItemCalendar b) {
    if (this.day.isBefore(b.day)) return -1;
    else if (this.day.isAfter(b.day)) return 1;
    else {
      if (this.hour.hour < b.hour.hour) return -1;
      if (this.hour.hour > b.hour.hour) return 1;
      else {
        if (this.hour.minute < b.hour.minute) return -1;
        if (this.hour.minute > b.hour.minute) return 1;
        else return 0;
      }
    }
  }
}