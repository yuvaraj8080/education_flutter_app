import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/image_string.dart';
import '../../utils/halpers/helper_function.dart';

Widget TOnlinePastTest(String text, BuildContext context) {
  final dark = THelperFunction.isDarkMode(context);
  return Padding(
    padding: EdgeInsets.only(left:5.w,top: 25.h,right:5.w),
    child: Container(height: 60.h, width: 130.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp), color:dark? TColors.dark:Colors.grey.shade200),
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top:8.0.h,left:10.0.w),
                child: Text(text,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontFamily: 'CircularStd')

                ),
              ),
              const Icon(Icons.arrow_right_alt_rounded,size:30)
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(TImages.pastTestImage,height:40,width:40),
          )
          //Image.asset("")
        ],
      ),
    ),
  );
}
