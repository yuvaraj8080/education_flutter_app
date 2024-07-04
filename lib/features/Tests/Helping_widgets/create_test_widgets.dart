import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ongoingtest(String WeekNumber,String Topic){

 return Padding(
   padding: EdgeInsets.only(top:20.w,left: 20.w,right: 20.w),
   child: Container(
    height:63.h ,
    width:336.w ,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp),color: TColors.black),
    child: Center(child: Text(WeekNumber+"-"+Topic,style: TextStyle(fontFamily: 'CircularStd',fontSize: 14.sp,fontWeight: FontWeight.w700,color: TColors.primaryBackground),)),
   ),
 ) ;
}

Widget completedtest(String WeekNumber,String Topic){
  return Padding(
   padding: EdgeInsets.only(top:20.w,left: 20.w,right: 20.w),
   child: Container(
    height:63.h ,
    width:336.w ,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp),border: Border.all(color: Colors.black)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 5.w,),
        Text(WeekNumber+"-"+Topic,style: TextStyle(fontFamily: 'CircularStd',fontSize: 14.sp,fontWeight: FontWeight.w700,color: TColors.dark),),
        SizedBox(width: 5.w,),
        underlinedText("Result"),
        SizedBox(width: 5.w,),
      ],
    ),
   ),
 ) ;
}