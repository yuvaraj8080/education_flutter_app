import 'package:cloud_firestore/cloud_firestore.dart';

class Week {
  final String weekNumber;
  final String topic;
  final String description;
  final int duration;
  final Timestamp createdAt;
  final bool isCompleted;

  Week({required this.weekNumber, required this.topic, required this.description,required this.duration,required this.createdAt,required this.isCompleted});
}