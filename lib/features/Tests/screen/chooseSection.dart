import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/create_test_widgets.dart';
import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';

import 'package:flutter_job_app/features/Tests/models/Testsingleton.dart';

import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/screen/Numericaltestpage.dart';
import 'package:flutter_job_app/features/Tests/screen/scorecard.dart';
import 'package:flutter_job_app/features/Tests/screen/testpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseSection extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String topic;
  final int duration;

  ChooseSection(
      {super.key,
      required this.batchName,
      required this.weekNumber,
      required this.topic,
      required this.duration});

  @override
  State<ChooseSection> createState() => _ChooseSectionState();
}

class _ChooseSectionState extends State<ChooseSection> {
  final TimerController _timerController =
      Get.put(TimerController(onFinish: () {}));
  final TestResultSingleton _testResultSingleton =
      TestResultSingleton.getInstance();
  @override
  void initState() {
    // TODO: implement initState

    _timerController.startTimer(widget.duration);
    super.initState();
  }

  void submitTest() async {
    int totalSkippedMcqQuestions = _testResultSingleton.testResult.mcqAnswers
        .where((answer) => answer == '')
        .length;
    int totalSkippedNumericalQuestions = _testResultSingleton
        .testResult.numericalAnswers
        .where((answer) => answer == '')
        .length;
    int totalSkippedQuestions =
        totalSkippedMcqQuestions + totalSkippedNumericalQuestions;

    _testResultSingleton.testResult.totalSkippedQuestions =
        totalSkippedQuestions;
    QuerySnapshot mcqquerySnapshot = await FirebaseFirestore.instance
        .collection('Tests')
        .doc(widget.batchName)
        .collection("weeks")
        .doc(widget.weekNumber)
        .collection("section")
        .doc('MCQquestions')
        .collection('QuestionSet')
        .get();
    QuerySnapshot numericalquerySnapshot = await FirebaseFirestore.instance
        .collection('Tests')
        .doc(widget.batchName)
        .collection("weeks")
        .doc(widget.weekNumber)
        .collection("section")
        .doc('Numericalquestions')
        .collection('QuestionSet')
        .get();
    String elapsedTime = _timerController.getElapsedTime();

    Get.off(Scorecard(
      Timetaken: elapsedTime,
      questionsSkipped: _testResultSingleton.testResult.totalSkippedQuestions,
      testScore: _testResultSingleton.testResult,
      mcqquestions: mcqquerySnapshot.docs,
      numericalquestions: numericalquerySnapshot.docs,
      mcqAnswers: _testResultSingleton.testResult.mcqAnswers,
      numericalAnswers: _testResultSingleton.testResult.numericalAnswers,
      weeknumber: widget.weekNumber,
      topicname: widget.topic,
    ));
  }

  void onTimeUp() {
    _timerController.onFinish = () async {
      QuerySnapshot mcqquerySnapshot = await FirebaseFirestore.instance
          .collection('Tests')
          .doc(widget.batchName)
          .collection("weeks")
          .doc(widget.weekNumber)
          .collection("section")
          .doc('MCQquestions')
          .collection('QuestionSet')
          .get();
      QuerySnapshot numericalquerySnapshot = await FirebaseFirestore.instance
          .collection('Tests')
          .doc(widget.batchName)
          .collection("weeks")
          .doc(widget.weekNumber)
          .collection("section")
          .doc('Numericalquestions')
          .collection('QuestionSet')
          .get();
      submitTest();

      String elapsedTime = _timerController.getElapsedTime();
      Get.to(() => Scorecard(
            Timetaken: elapsedTime,
            numericalquestions: numericalquerySnapshot.docs,
            questionsSkipped:
                _testResultSingleton.testResult.totalSkippedQuestions,
            testScore: _testResultSingleton.testResult,
            mcqquestions: mcqquerySnapshot.docs,
            mcqAnswers: _testResultSingleton.testResult.mcqAnswers,
            numericalAnswers: _testResultSingleton.testResult.numericalAnswers,
            weeknumber: widget.weekNumber,
            topicname: widget.topic,
          ));
    };
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to exit the test?'),
        content: Text(
            'Your progress till now will be used to calculate your final score'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              _timerController.stopTimer();
              _timerController.dispose();
              _testResultSingleton.reset();
              submitTest();

              // Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    onTimeUp();
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TSectionHeading(
                        context, ' ${_timerController.timerDisplay} remaining',
                        size: 14.sp),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              child: ongoingtest('MCQ QUESTIONS', ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Testpage(
                        batchName: widget.batchName,
                        weekNumber: widget.weekNumber,
                        topic: widget.topic,
                        section: 'MCQquestions',
                        duration: widget.duration),
                  ),
                );
              },
            ),
            GestureDetector(
              child: ongoingtest('NUMERICAL QUESTIONS', ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NumericalTestPage(
                        batchName: widget.batchName,
                        weekNumber: widget.weekNumber,
                        topic: widget.topic,
                        section: 'Numericalquestions',
                        duration: widget.duration),
                  ),
                );
              },
            ),
            SizedBox(
              height: 200,
            ),
            GestureDetector(
                onTap: () async {
                  // QuerySnapshot mcqquerySnapshot = await FirebaseFirestore
                  //     .instance
                  //     .collection('Tests')
                  //     .doc(widget.batchName)
                  //     .collection("weeks")
                  //     .doc(widget.weekNumber)
                  //     .collection("section")
                  //     .doc('MCQquestions')
                  //     .collection('QuestionSet')
                  //     .get();

                  // QuerySnapshot numericalquerySnapshot = await FirebaseFirestore
                  //     .instance
                  //     .collection('Tests')
                  //     .doc(widget.batchName)
                  //     .collection("weeks")
                  //     .doc(widget.weekNumber)
                  //     .collection("section")
                  //     .doc('Numericalquestions')
                  //     .collection('QuestionSet')
                  //     .get();

                  submitTest();

                  // String elapsedTime = _timerController
                  //     .getElapsedTime(); //this  records the time taken by the student

                  // Get.off(Scorecard(
                  //   Timetaken: elapsedTime,
                  //   questionsSkipped:
                  //       _testResultSingleton.testResult.totalSkippedQuestions,
                  //   testScore: _testResultSingleton.testResult,
                  //   mcqquestions: mcqquerySnapshot.docs,
                  //   numericalquestions: numericalquerySnapshot.docs,
                  //   mcqAnswers: _testResultSingleton.testResult.mcqAnswers,
                  //   numericalAnswers:
                  //       _testResultSingleton.testResult.numericalAnswers,
                  //   weeknumber: widget.weekNumber,
                  //   topicname: widget.topic,
                  // ));
                },
                child: Utils().ElevatedButton("Submit", TColors.redtext))
          ],
        ),
      ),
    );
  }
}
