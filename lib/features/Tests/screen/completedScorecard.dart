
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';

import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/scorecard_widgets.dart';


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

  completedScorecard({
    
    required this.totalCorrectAnswers,
    required this.totalquestionsSkipped,
    required this.totalWrongAnswers,
    required this.totalQuestions, 
    required this.weeknumber,
    required this.topicname,
  });

  @override
  State<completedScorecard> createState() => _completedScorecardState();
}

class _completedScorecardState extends State<completedScorecard> {
  
  @override
  void initState() {
    
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
                 
                  card(context,widget.totalQuestions,  widget.totalCorrectAnswers,  widget.totalquestionsSkipped,  widget.totalWrongAnswers),
                  SizedBox(
                    height: 20.h,
                  ),
                
                  GestureDetector(
                      onTap: () => Get.off(() => NavigationMenu()),
                      child: Utils()
                          .ElevatedButton('Back To Home', TColors.black)),
                ]),
              )
        );
  }
}
