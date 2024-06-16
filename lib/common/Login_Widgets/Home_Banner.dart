import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/image_string.dart';

Widget TSectionBanner() {
  return SizedBox(height: 150.h,  width: 342.w,
    child: ClipRRect(borderRadius: BorderRadius.circular(15.r),
        child: Image.asset(TImages.homeBanner, fit: BoxFit.cover)),
  );
}