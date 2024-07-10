
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';

import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/scorecard_widgets.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';


import 'package:flutter_job_app/navigation_menu.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class completedScorecard extends StatefulWidget {
  int totalCorrectAnswers;
  int totalquestionsSkipped;
  int totalWrongAnswers;
  int totalQuestions;

  final String weeknumber;
  final String topicname;
  final String Timetaken;

  completedScorecard({
    
    required this.totalCorrectAnswers,
    required this.totalquestionsSkipped,
    required this.totalWrongAnswers,
    required this.totalQuestions, 
    required this.weeknumber,
    required this.topicname,
    required this.Timetaken
  });

  @override
  State<completedScorecard> createState() => _completedScorecardState();
}

class _completedScorecardState extends State<completedScorecard> {
  final controller = Get.put(UserController());
  late  String studentID;
  late String batchName;
  @override
  void initState() {
     studentID = controller.user.value.studentId; 
     batchName=controller.user.value.batch;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        //backgroundColor: TColors.green,
        body: Center(
                child: Column(children: [
                  TSectionHeading(context, widget.weeknumber,
                      size: 16.h, textColor: TColors.black),
                  SizedBox(
                    height: 30.h,
                  ),
                  TSectionHeading(context, widget.topicname,
                      size: 24.h, textColor: TColors.black),
                 
                  SizedBox(
                    height: 30.h,
                  ),
                 
                  card(context,widget.totalQuestions,  widget.totalCorrectAnswers,  widget.totalquestionsSkipped,  widget.totalWrongAnswers,studentID,batchName,widget.Timetaken),
                  SizedBox(
                    height: 20.h,
                  ),
                
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Utils()
                          .ElevatedButton('Back', TColors.black)),
                ]),
              )
        );
  }
}
