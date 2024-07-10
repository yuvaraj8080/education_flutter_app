import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget scoreTable(String Weeknumber, int correctAnswer, int totalquestion,
    int skippedquestions, int wrongAnswers) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: TColors.primaryBackground,
      ),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(1.0),
          1: FlexColumnWidth(1.0),
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Batch')),
              ),
              TableCell(
                child: Center(child: Text('JEE-11th')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('correct questions')),
              ),
              TableCell(
                child: Center(child: Text('$correctAnswer')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('skipped questions')),
              ),
              TableCell(
                child: Center(child: Text('$skippedquestions')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('wrong answers')),
              ),
              TableCell(
                child: Center(child: Text('$wrongAnswers')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Total questions')),
              ),
              TableCell(
                child: Center(child: Text('$totalquestion')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Marks Scored')),
              ),
              TableCell(
                child: Center(child: Text('$correctAnswer')),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Percentage')),
              ),
              TableCell(
                child: Center(
                    child: Text('${(correctAnswer / totalquestion) * 100}%')),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget card(BuildContext context, int totalQuestions, int correctAnswers,
    int skippedQuestions, int wrongAnswers,String studentID,String batch,String Timetaken) {
    int totalscore=(correctAnswers*4)-wrongAnswers;   
 double _calculateProgressValue() {
  //int totalscore=(correctAnswers*4)-wrongAnswers;
  double score = totalscore.toDouble();
  double totalquestions = totalQuestions.toDouble();
  double progress = score / (totalquestions*4.0);

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 10,),
                TSectionHeading(context, "Batch: ",size: 14.sp,textColor: TColors.black.withOpacity(0.5)),
                TSectionHeading(context, batch,size: 14.sp),
                TSectionHeading(context, "Student ID: ",size: 14.sp,textColor: TColors.black.withOpacity(0.5)),
                TSectionHeading(context, studentID,size: 14.sp),
                TSectionHeading(context, "Total Questions:",size: 14.sp,textColor: TColors.black.withOpacity(0.5)),
                TSectionHeading(context, " $totalQuestions",size: 14.sp),
                TSectionHeading(context, "Total Timetaken:",size: 14.sp,textColor: TColors.black.withOpacity(0.5)),
                TSectionHeading(context, Timetaken,size: 14.sp),
                SizedBox(height: 10,),
                Row(
                  children: [
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
                         TSectionHeading(context,"Correct",size: 14.sp)   
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
                         TSectionHeading(context,"Skipped",size: 14.sp)   
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
                         TSectionHeading(context,"Wrong",size: 14.sp)   
                      ],
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20.h,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                 width: 70, // increase the width to increase the radius
                 height: 70, // increase the height to increase the radius
                 child: CircularProgressIndicator(
                      value: _calculateProgressValue(),
                      strokeWidth: 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(TColors.blue),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                    Text(
                      '${totalscore} / ${totalQuestions*4}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TSectionHeading(context, "Your Score",size: 16.sp),
                SizedBox(height: 20.h,)
              ],
            )
          ],
        ),
      ),
    ),
  );
}
