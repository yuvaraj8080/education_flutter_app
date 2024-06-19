import 'package:cloud_firestore/cloud_firestore.dart';

class databaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addQuestion(Map<String, dynamic> question, String subjectName) async {
    try {
     final docRef= await _firestore.collection("subjects").doc(subjectName).collection("Week Test").doc();
      return docRef.set(question);
     
    } catch (error) {
      print('Error adding question: $error');
    }
  }

  Future<Stream<QuerySnapshot>> getSubjectQuestions(String subject) async {
    try {
      final questionsCollection = _firestore.collection("subjects").doc(subject).collection("Week Test");
      return questionsCollection.snapshots();
    } catch (error) {
     
      // You can return an empty stream or handle the error differently here
      return Stream.empty();
    }
  }
}
