
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_job_app/features/Tests/models/Week.dart';
import 'package:get/get.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addQuestion(Map<String, dynamic> question, String batchName,String weeknumber,String sectionName) async {
    try {
     final docRef= await _firestore.collection("Tests").doc(batchName).collection("weeks").doc(weeknumber).collection("section").doc(sectionName).collection("QuestionSet").doc();
      return docRef.set(question);
     
    } catch (error) {
      print('Error adding question: $error');
    }
  }

  Future<Stream<QuerySnapshot>> getSubjectQuestions(String batchName,String weeknumber,String sectionName) async {
    try {
      final questionsCollection = _firestore.collection("Tests").doc(batchName).collection("weeks").doc(weeknumber).collection("section").doc(sectionName).collection("QuestionSet");
      return questionsCollection.snapshots();
    } catch (error) {
     
      // You can return an empty stream or handle the error differently here
      return Stream.empty();
    }
  }


 Future<void> createWeek(String batchName, String weekNumber, String topic, String description) async {
  if (batchName.isEmpty || weekNumber.isEmpty) {
    print('Error creating week: Batch name or week number is empty');
    return;
  }

  if (topic.isEmpty || description.isEmpty) {
    print('Error creating week: Topic, description, or duration is empty');
    return;
  }

  try {
    final weekRef = _firestore.collection('Tests').doc(batchName).collection('weeks').doc(weekNumber);
    if (weekRef!= null) {
      await weekRef.set({
        'topic': topic,
        'description': description,
        
      });
    } else {
      print('Error creating week: Week reference is null');
    }
  } catch (e) {
    print('Error creating week: $e');
  }
}
Future<void> createSection(String batchName, String weekNumber, String section, int numberOfquestions,int duration) async {
  

  try {
    final sectionRef = _firestore.collection('Tests').doc(batchName).collection('weeks').doc(weekNumber).collection("section").doc(section);
    if (sectionRef!= null) {
      await sectionRef.set({
        'numberOfquestions':numberOfquestions,
        'duration':duration
        
      });
    } else {
      print('Error creating week: Week reference is null');
    }
  } catch (e) {
    print('Error creating week: $e');
  }
}




Future<List<Week>> getWeeks(String batchName) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('Tests')
            .doc(batchName)
            .collection('weeks')
            .get();

    List<Week> weeks = querySnapshot.docs.map((doc) {
      return Week(
        weekNumber: doc.id,
        topic: doc['topic'] ?? '',
        description: doc['description'] ?? '',
        duration: doc['duration']??0,
       
      );
    }).toList();

    return weeks;
  } catch (e) {
    print('Error getting weeks: $e');
    return [];
  }
}


Future<DocumentSnapshot> getWeekDocument(String batchName, String weekNumber,String sectionName) async {
  return FirebaseFirestore.instance
     .collection("Tests")
     .doc(batchName)
     .collection("weeks")
     .doc(weekNumber)    
     .get();
}



}
