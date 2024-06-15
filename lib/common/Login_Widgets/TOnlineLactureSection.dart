import 'package:flutter/material.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/image_string.dart';

Widget TOnlineLactureSection(BuildContext context) {
  final dark = THelperFunction.isDarkMode(context);
  return Padding(
    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20),
    child: Container(
      height: 55.h,width: 320.w,
      decoration: BoxDecoration(
          color: dark? TColors.darkGrey : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          boxShadow:  [
            BoxShadow(
              offset: Offset(0, 4), blurRadius:2,spreadRadius: 0,color: dark ? TColors.darkGrey : TColors.grey
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w,right: 10),
            child: Text(
              "Join on going lecture",
              style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,
                  fontFamily: 'CircularStd',color: TColors.redtext),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(TImages.liveClass, height:60.h,
            ),
          )
        ],
      ),
    ),
  );
}