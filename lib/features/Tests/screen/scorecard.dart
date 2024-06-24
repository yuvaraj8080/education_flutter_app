
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/scorecard_widgets.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';

import 'package:flutter_job_app/features/Tests/screen/Answerkey.dart';
import 'package:flutter_job_app/navigation_menu.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Scorecard extends StatelessWidget {
  final int totalMarksScored;
  final int totalQuestions;
  final int totalWrongAnswers;
  final List<DocumentSnapshot> questions;
  final List<String> selectedAnswers;
  final String weeknumber;
  final String topicname;

  Scorecard({
    required this.totalMarksScored,
    required this.totalQuestions,
    required this.totalWrongAnswers,
    required this.questions,
    required this.selectedAnswers,
    required this.weeknumber,
    required this.topicname,

  });

  @override
  Widget build(BuildContext context) {
   int i;
   int answerskipped=0;
   for(i=0;i<selectedAnswers.length;i++){
    if(selectedAnswers[i]==''){
      answerskipped++;
    }
   } 

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        
      ),
      backgroundColor: TColors.green,
      
      body: questions != null && selectedAnswers != null
        ?Center(
        child: Column(
          
          children: [
            TSectionHeading(context, weeknumber,size: 16.h,textColor: TColors.primaryBackground),
            SizedBox(height: 30.h,),
            TSectionHeading(context, topicname,size: 24.h,textColor: TColors.primaryBackground),
             SizedBox(height: 10.h,),
            TSectionHeading(context, 'You have successfully submitted the test',size: 14.h,textColor: TColors.primaryBackground), 
            SizedBox(height: 30.h,),
            scoreTable(weeknumber, totalMarksScored, totalQuestions,answerskipped,totalWrongAnswers),
            SizedBox(height: 20.h,),
            GestureDetector(onTap: () => Get.to(()=>AnswerKeyPage(questions: questions, selectedAnswers: selectedAnswers)),child: underlinedText("view answer key")),
           SizedBox(height: 30.h,),

            GestureDetector(onTap: () => Get.off(()=>NavigationMenu()),child: Utils().ElevatedButton('Back To Home',TColors.black)),
            
          ]    
        ),
      ):CircularProgressIndicator()
    );
  }
}
