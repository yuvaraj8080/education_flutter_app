import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget Question(String image){
  return  Container(
            height: 100.h,
            width: 300.w,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber
                ), 
               child: Image.network(image),        
          );
}
 
Widget Testbanner(BuildContext context,String Weeknumber,String Topic){

  return Container(
    height: 80.h,
    width: MediaQuery.of(context).size.width,
    color: TColors.black,
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TSectionHeading(context,Weeknumber,size:24.h ,textColor: TColors.primaryBackground),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TSectionHeading(context,Topic,size:14.sp,textColor: TColors.primaryBackground  ),
            ],
          ),
        ],
      ),
    )
  );
} 

Widget underlinedText(String text){
  return  Padding(
    padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
    child: Text(text,
    style:  TextStyle(
     decoration: TextDecoration.underline,
     decorationColor:TColors.black ,
     fontSize: 16.sp,
     fontFamily: 'CircularStd',
     fontWeight: FontWeight.w700
    
    ),),
  );
}