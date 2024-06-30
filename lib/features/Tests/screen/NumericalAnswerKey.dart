import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../common/Login_Widgets/TSection_Heading.dart';

class NumericalAnswerKeyPage extends StatelessWidget {
  final List<DocumentSnapshot> questions;
  final List<String> selectedAnswers;

  const NumericalAnswerKeyPage(
      {Key? key, required this.questions, required this.selectedAnswers})
      : super(key: key);
      

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        appBar: AppBar(
          title: Text('Answer Key'),
        ),
        body: questions != null && selectedAnswers != null
            ? ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return buildQuestion(
                      questions[index], index, selectedAnswers[index], context);
                },
              )
            : CircularProgressIndicator());
  }

  Widget buildQuestion(DocumentSnapshot ds, int index, String selectedAnswer,
      BuildContext context) {
        
    String correctOption = ds["Correct Option"];
    String studentAnswer=selectedAnswer;
    

    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              TSectionHeading(context, 'Q${index+1} ', size: 24.sp),
              Question(ds["Image"]),
            ],
          ),
        ),
       Container(
            child: TSectionHeading(context, 'Your Answer: $studentAnswer ',
                size: 16.h, textColor: TColors.black)),
        SizedBox(
          height: 20.h,
        ),
        Container(
            child: TSectionHeading(context, 'Solution:  $correctOption',
                size: 16.h, textColor: TColors.green)),
        Divider(
          thickness: 1, // thickness of the divider
          color: Colors.grey, // color of the divider
        )
      ],
    );
  }
}
