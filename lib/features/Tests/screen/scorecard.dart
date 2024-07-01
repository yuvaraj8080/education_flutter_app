import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';
import 'package:flutter_job_app/features/Tests/models/Testsingleton.dart';
import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/scorecard_widgets.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';

import 'package:flutter_job_app/features/Tests/models/testresult.dart';

import 'package:flutter_job_app/features/Tests/screen/MCQAnswerkey.dart';
import 'package:flutter_job_app/features/Tests/screen/NumericalAnswerKey.dart';
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

  Scorecard({
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
  @override
  void initState() {
    Get.delete<TimerController>();
    _testResultSingleton = TestResultSingleton.getInstance();
    _updateSectionAnswers();
    super.initState();
  }
  void _updateSectionAnswers() {
    // Check if MCQAnswers is empty
    if (widget.mcqAnswers.isEmpty) {
      int numMCQQuestions = widget.mcqquestions.length;
      widget.mcqAnswers = List.filled(numMCQQuestions, '');
       widget.questionsSkipped += numMCQQuestions;
       widget.testScore.totalQuestions+=numMCQQuestions;
    }

    // Check if NumericalAnswers is empty
    if ( widget.numericalAnswers.isEmpty) {
      int numNumericalQuestions = widget.numericalquestions.length;
      widget.numericalAnswers = List.filled(numNumericalQuestions, '');
      widget.questionsSkipped += numNumericalQuestions;
      widget.testScore.totalQuestions+=numNumericalQuestions;
    }
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
        ),
        //backgroundColor: TColors.green,
        body: widget.mcqquestions != null && widget.mcqAnswers != null
            ? Center(
                child: Column(children: [
                  TSectionHeading(context, widget.weeknumber,
                      size: 16.h, textColor: TColors.black),
                  SizedBox(
                    height: 30.h,
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
                  // scoreTable(
                  //     widget.weeknumber,
                  //     widget.testScore.totalCorrectAnswers,
                  //     widget.testScore.totalQuestions,
                  //     widget.questionsSkipped,
                  //     widget.testScore.totalWrongAnswers),
                  card(context,widget.testScore.totalQuestions,  widget.testScore.totalCorrectAnswers,  widget.questionsSkipped,  widget.testScore.totalWrongAnswers),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                      onTap: () => Get.to(() => MCQAnswerKeyPage(
                          questions: widget.mcqquestions,
                          selectedAnswers: widget.mcqAnswers)),
                      child: underlinedText("view answer key for MCQs")),
                   SizedBox(
                    height: 15.h,
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
                      onTap: () => Get.off(() => NavigationMenu()),
                      child: Utils()
                          .ElevatedButton('Back To Home', TColors.black)),
                ]),
              )
            : CircularProgressIndicator());
  }
}
