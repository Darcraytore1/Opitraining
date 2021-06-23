import 'package:flutter/material.dart';

class ItemCalendar {

  String id;
  TimeOfDay hour;
  DateTime day;

  ItemCalendar(String id, TimeOfDay hour, DateTime day) {
    this.id = id;
    this.hour = hour;
    this.day = day;
  }

  TimeOfDay getHour() {
    return hour;
  }

  DateTime getDay() {
    return day;
  }

  String getId() {
    return id;
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