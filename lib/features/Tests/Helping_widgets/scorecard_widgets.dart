import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/constants/sizes.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/Student_Details/quetions_cards.dart';
import '../../../common/Student_Details/student_details.dart';

Widget StudentScoreCard(
    BuildContext context,
   int totalQuestions,
    int correctAnswers,
    int skippedQuestions,
    int wrongAnswers,
    String studentID,
    String batch,
    String name,
    String Timetaken) {
    int totalscore = (correctAnswers * 4) - wrongAnswers;

    double _calculateProgressValue() {
  
    double score = totalscore.toDouble();
    double totalquestions = totalQuestions.toDouble();
    double progress = score / (totalquestions * 4.0);

    // Map the progress value to a value between 0 and 1
    progress = progress.clamp(0.0, 1.0);

    return progress;
  }

  

  return Card(
    color: THelperFunction.isDarkMode(context) ? TColors.dark : Colors.grey.shade200,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          SizedBox(height:TSizes.size12),
          Text("Name: ANUJEET KUNTUNKAR",style:Theme.of(context).textTheme.titleLarge,overflow:TextOverflow.ellipsis),
          SizedBox(height:TSizes.size12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           Column(
             crossAxisAlignment:CrossAxisAlignment.start,
             children: [
               TStudentDetails(name:"Batch: ${batch}"),
               TStudentDetails(name:"Student ID: ${studentID}"),
               TStudentDetails(name:"Total Questions: ${totalQuestions}"),
               TStudentDetails(name:"Total Timetaken: ${Timetaken}"),
             ],
           ),
           Stack(
             alignment: Alignment.center,
             children: [
               Container(
                 width:
                 80, // increase the width to increase the radius
                 height:
                 80, // increase the height to increase the radius
                 child: CircularProgressIndicator(
                   value: _calculateProgressValue(),
                   strokeWidth: 10,
                   backgroundColor: Colors.grey.shade300,
                   valueColor: AlwaysStoppedAnimation(TColors.blue),
                   strokeCap: StrokeCap.round,
                 ),
               ),
               Text(
                 '${totalscore} / ${totalQuestions * 4}',
                 style:Theme.of(context).textTheme.headlineSmall
               ),
             ],
           ),
            ],),
          SizedBox(
            height: 30.h,
          ),
          QuetionsCards(context, correctAnswers, skippedQuestions, wrongAnswers)
        ],
      ),
    ),
  );
}


