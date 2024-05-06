import 'package:flutter/material.dart';



class Meeting {
  Meeting({required this.clientName, required this.time, required this.date, required this.eventName, required this.from, required this.to, required this.background, required this.isAllDay});
  
  final String eventName;
  final String clientName;
  final String time;
  final String date;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  
}