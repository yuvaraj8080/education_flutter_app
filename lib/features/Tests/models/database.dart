import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_job_app/features/Tests/models/CompletedTest.dart';
import 'package:flutter_job_app/features/Tests/models/Week.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addQuestion(Map<String, dynamic> question, String batchName,
      String weeknumber, String sectionName) async {
    try {
      final docRef = await _firestore
          .collection("Tests")
          .doc(batchName)
          .collection("weeks")
          .doc(weeknumber)
          .collection("section")
          .doc(sectionName)
          .collection("QuestionSet")
          .doc();
      return docRef.set(question);
    } catch (error) {
      print('Error adding question: $error');
    }
  }

  Future<Stream<QuerySnapshot>> getSubjectQuestions(
      String batchName, String weeknumber, String sectionName) async {
    try {
      final questionsCollection = _firestore
          .collection("Tests")
          .doc(batchName)
          .collection("weeks")
          .doc(weeknumber)
          .collection("section")
          .doc(sectionName)
          .collection("QuestionSet");
      return questionsCollection.snapshots();
    } catch (error) {
      // You can return an empty stream or handle the error differently here
      return Stream.empty();
    }
  }

  Future<void> createWeek(String batchName, String weekNumber, String topic,
      String description) async {
    if (batchName.isEmpty || weekNumber.isEmpty) {
      print('Error creating week: Batch name or week number is empty');
      return;
    }

    if (topic.isEmpty || description.isEmpty) {
      print('Error creating week: Topic, description, or duration is empty');
      return;
    }

    try {
      final weekRef = _firestore
          .collection('Tests')
          .doc(batchName)
          .collection('weeks')
          .doc(weekNumber);

      await weekRef.set({
        'topic': topic,
        'description': description,
      });
    } catch (e) {
      print('Error creating week: $e');
    }
  }

  Future<void> createSection(String batchName, String weekNumber,
      String section, int numberOfquestions, int duration) async {
    try {
      final sectionRef = _firestore
          .collection('Tests')
          .doc(batchName)
          .collection('weeks')
          .doc(weekNumber)
          .collection("section")
          .doc(section);

      await sectionRef
          .set({'numberOfquestions': numberOfquestions, 'duration': duration});
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
            duration: doc['duration'] ?? 0,
            createdAt: doc['createdAt'] ?? ''
        );
            
      }).toList();

      return weeks;
    } catch (e) {
      print('Error getting weeks: $e');
      return [];
    }
  }

  Future<DocumentSnapshot> getWeekDocument(
      String batchName, String weekNumber, String sectionName) async {
    return FirebaseFirestore.instance
        .collection("Tests")
        .doc(batchName)
        .collection("weeks")
        .doc(weekNumber)
        .get();
  }

   Future<void> submitCompletedTest(String studentID, CompletedTest completedTest) async {
    final completedTestsRef = _firestore.collection('completed_tests').doc(studentID).collection('tests');
    await completedTestsRef.add(completedTest.toMap());
  }

   final controller = Get.put(UserController());
   
  Stream<QuerySnapshot> getCompletedTests() {
    String studentID = controller.user.value.studentId; 
    return _firestore.collection('completed_tests').doc(studentID).collection('tests').snapshots();
  }

   Future<int> fetchRemainingTestsCount() async {
    String studentID= Get.find<UserController>().user.value.studentId;
    String batchName= Get.find<UserController>().user.value.batch;
     print('Student ID: $studentID'); 
    final weeksCollection = FirebaseFirestore.instance.collection('Tests').doc(batchName).collection('weeks');
    final completedTestsCollection = FirebaseFirestore.instance.collection('completed_tests').doc(studentID).collection('tests');

    final weeksSnapshot = await weeksCollection.get();
    final completedTestsSnapshot = await completedTestsCollection.get();

    int totalTests = weeksSnapshot.docs.length;
    print('total test ${totalTests}');
  
    int completedTestsCount = completedTestsSnapshot.docs.length;
     print('completed test ${completedTestsCount}');

    int remainingTestsCount = totalTests - completedTestsCount;

    return remainingTestsCount;
  }

   Stream<int> getRemainingTestsCountStream() {
    String studentID = Get.find<UserController>().user.value.studentId;
    String batchName = Get.find<UserController>().user.value.batch;

    final weeksCollection = _firestore.collection('Tests').doc(batchName).collection('weeks');
    final completedTestsCollection = _firestore.collection('completed_tests').doc(studentID).collection('tests');

    return CombineLatestStream(
      [
        weeksCollection.snapshots().map((snapshot) => snapshot.docs.length),
        completedTestsCollection.snapshots().map((snapshot) => snapshot.docs.length),
      ],
      (values) => values[0] - values[1],
    );
  }

}
