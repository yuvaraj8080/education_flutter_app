import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';
import 'package:flutter_job_app/features/Tests/models/CompletedTest.dart';
import 'package:flutter_job_app/features/Tests/models/Testsingleton.dart';
import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/scorecard_widgets.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';

import 'package:flutter_job_app/features/Tests/models/testresult.dart';

import 'package:flutter_job_app/features/Tests/screen/MCQAnswerkey.dart';
import 'package:flutter_job_app/features/Tests/screen/NumericalAnswerKey.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter_job_app/navigation_menu.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Scorecard extends StatefulWidget {
  final TestResult testScore;

  final List<DocumentSnapshot> mcqquestions;
  final List<DocumentSnapshot> numericalquestions;
  List<String> mcqAnswers;
  List<String> numericalAnswers;
  int questionsSkipped;
  final String weeknumber;
  final String topicname;
  final String Timetaken;

  Scorecard({
    required this.Timetaken,
    required this.numericalAnswers,
    required this.numericalquestions,
    required this.testScore,
    required this.questionsSkipped,
    required this.mcqquestions,
    required this.mcqAnswers,
    required this.weeknumber,
    required this.topicname,
  });

  @override
  State<Scorecard> createState() => _ScorecardState();
}

class _ScorecardState extends State<Scorecard> {
  late TestResultSingleton _testResultSingleton;
  final controller = Get.put(UserController());
  late String studentID;
  late String batchName;
  late String name;

  @override
  void initState() {
    studentID = controller
        .user.value.studentId; // Replace with your method to get the student ID
    batchName = controller.user.value.batch;
    name=controller.user.value.fullName;

    Get.delete<TimerController>();
    _testResultSingleton = TestResultSingleton.getInstance();
    _updateSectionAnswers();
    super.initState();
  }

  void _updateSectionAnswers() async {
    // Check if MCQAnswers is empty
    if (widget.mcqAnswers.isEmpty) {
      int numMCQQuestions = widget.mcqquestions.length;
      widget.mcqAnswers = List.filled(numMCQQuestions, '');
      widget.questionsSkipped += numMCQQuestions;
      widget.testScore.totalQuestions += numMCQQuestions;
    }

    // Check if NumericalAnswers is empty
    if (widget.numericalAnswers.isEmpty) {
      int numNumericalQuestions = widget.numericalquestions.length;
      widget.numericalAnswers = List.filled(numNumericalQuestions, '');
      widget.questionsSkipped += numNumericalQuestions;
      widget.testScore.totalQuestions += numNumericalQuestions;
    }
    CompletedTest completedTest = CompletedTest(
        weekNumber: widget.weeknumber,
        topic: widget.topicname,
        totalCorrectAnswers: widget.testScore.totalCorrectAnswers,
        totalQuestions: widget.testScore.totalQuestions,
        totalWrongAnswers: widget.testScore.totalWrongAnswers,
        totalSkippedQuestions: widget.questionsSkipped,
        Timetaken: widget.Timetaken);

    // Get the current student ID

    // Add the completed test to Firestore
    await DatabaseService().submitCompletedTest(studentID, completedTest);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _testResultSingleton.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('RESULT'),
          centerTitle: true,
        ),
        //backgroundColor: TColors.green,
        body: widget.mcqquestions != null && widget.mcqAnswers != null
            ? Center(
                child: Column(children: [
                   SizedBox(
                    height: 24.h,
                  ),
                  TSectionHeading(context, widget.weeknumber,
                      size: 16.h, textColor: TColors.black),
                  SizedBox(
                    height: 24.h,
                  ),
                  TSectionHeading(context, widget.topicname,
                      size: 24.h, textColor: TColors.black),
                  SizedBox(
                    height: 10.h,
                  ),
                  TSectionHeading(
                      context, 'You have successfully submitted the test',
                      size: 14.h, textColor: TColors.black),
                  SizedBox(
                    height: 30.h,
                  ),
                  card(
                      context,
                      widget.testScore.totalQuestions,
                      widget.testScore.totalCorrectAnswers,
                      widget.questionsSkipped,
                      widget.testScore.totalWrongAnswers,
                      studentID,
                      batchName,
                      name,
                      widget.Timetaken
                      ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                      onTap: () => Get.to(() => MCQAnswerKeyPage(
                          questions: widget.mcqquestions,
                          selectedAnswers: widget.mcqAnswers)),
                      child: underlinedText("view answer key for MCQs")),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                      onTap: () => Get.to(() => NumericalAnswerKeyPage(
                          questions: widget.numericalquestions,
                          selectedAnswers: widget.numericalAnswers)),
                      child: underlinedText("view answer key for Numericals")),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                      onTap: () {
                          Get.find<NavigationController>().navigateToHome();
                        //Get.off(() => NavigationMenu());
                      },
                      child: Utils()
                          .ElevatedButton('Back To Home', TColors.black)),
                ]),
              )
            : CircularProgressIndicator());
  }
}
