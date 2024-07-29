import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../common/Login_Widgets/TSection_Heading.dart';

class MCQAnswerKeyPage extends StatelessWidget {
  final List<DocumentSnapshot> questions;
  final List<String> selectedAnswers;

  const MCQAnswerKeyPage(
      {Key? key, required this.questions, required this.selectedAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Answer Key'),
        ),
        body: selectedAnswers != null
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
    List<String> options = [
      ds["Option1"],
      ds["Option2"],
      ds["Option3"],
      ds["Option4"]
    ];

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
        ...options.map((option) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 50,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  option == selectedAnswer
                      ? Icons.circle
                      : Icons.circle_outlined,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    option,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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
