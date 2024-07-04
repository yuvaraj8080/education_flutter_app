import 'package:cloud_firestore/cloud_firestore.dart';

class Week {
  final String weekNumber;
  final String topic;
  final String description;
  final int duration;
  final Timestamp createdAt;
  

  Week({required this.weekNumber, required this.topic, required this.description,required this.duration,required this.createdAt});
}