import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../Login_Widgets/TSection_Heading.dart';

Widget QuetionsCards(BuildContext context, int correctAnswers, int skippedQuestions, int wrongAnswers) {
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
