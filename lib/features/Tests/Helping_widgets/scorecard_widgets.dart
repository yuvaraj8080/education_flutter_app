import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';









Widget card(
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

  

  return SizedBox(
    height: 250.h,
    width: 300.w,
    child: Card(
      color: TColors.primaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TSectionHeading(context, "Batch: ${batch}",
                        size: 16.sp, textColor: TColors.black,),

                    TSectionHeading(context, "Name: ${name}",
                        size: 16.sp, textColor: TColors.black,),    
                    
                    TSectionHeading(context, "Student ID:${studentID} ",
                        size: 16.sp, textColor: TColors.black),
                   
                    TSectionHeading(context, "Total Questions:${totalQuestions}",
                        size: 16.sp, textColor: TColors.black),
                   
                    TSectionHeading(context, "Total Timetaken:${Timetaken}",
                        size: 16.sp, textColor: TColors.black),
                    
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width:
                              70, // increase the width to increase the radius
                          height:
                              70, // increase the height to increase the radius
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
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TSectionHeading(context, "Your Score", size: 16.sp),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            cardboxes(context, correctAnswers, skippedQuestions, wrongAnswers)
            
          ],
        ),
      ),
    ),
  );
}

Widget cardboxes(BuildContext context, int correctAnswers, int skippedQuestions,
    int wrongAnswers) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SizedBox(width: 20.w),
      Column(
        children: [
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: TColors.green,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                child: TSectionHeading(
                  context,
                  correctAnswers.toString(),
                ),
              )),
          TSectionHeading(context, "Correct", size: 14.sp)
        ],
      ),
      SizedBox(
        width: 10.w,
      ),
      Column(
        children: [
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: TColors.yellow,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                child: TSectionHeading(
                  context,
                  skippedQuestions.toString(),
                ),
              )),
          TSectionHeading(context, "Skipped", size: 14.sp)
        ],
      ),
      SizedBox(
        width: 10.w,
      ),
      Column(
        children: [
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: TColors.redtext,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(
                child: TSectionHeading(
                  context,
                  wrongAnswers.toString(),
                ),
              )),
          TSectionHeading(context, "Wrong", size: 14.sp)
        ],
      ),
      SizedBox(width: 20.w),
    ],
  );
}
