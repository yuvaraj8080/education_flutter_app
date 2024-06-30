import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Home/controller/Url_Launcher_Controller.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/colors.dart';
import '../../constants/image_string.dart';

Widget TOnlineLectureSection(BuildContext context) {

  final dark = THelperFunction.isDarkMode(context);
  final urlController = Get.put(UrlController());

  return Padding(
    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20),
    child: Container(
      height: 55.h,width: 320.w,
      decoration: BoxDecoration(
          color: dark? TColors.dark : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          boxShadow:  [
            BoxShadow(
              offset: Offset(0,0), blurRadius:0,color: dark ? TColors.white : TColors.grey
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
                  fontFamily: 'CircularStd',color: dark?TColors.primaryBackground:TColors.redtext),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: InkWell(
              onTap:()=> urlController.launchLink(Uri.parse('https://www.linkedin.com/in/yuvaraj-dekhane-473064297/')),
                child: Image.asset(TImages.liveClass, height:60.h,)),
          )
        ],
      ),
    ),
  );
}