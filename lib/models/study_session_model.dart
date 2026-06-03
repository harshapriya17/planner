import 'package:flutter/material.dart';
class StudySession {
  int id;
  int subjectId;
  String day;
  TimeOfDay startTime;
  TimeOfDay enfTime;

  StudySession({
    required this.id,
    required this.subjectId,
    required this.day,
    required this.startTime,
    required this.enfTime,
});

}