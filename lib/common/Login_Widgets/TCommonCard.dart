import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/image_string.dart';
import '../../utils/halpers/helper_function.dart';

Widget CommonCard(String text, BuildContext context) {
  final dark = THelperFunction.isDarkMode(context);
  return Padding(
    padding: EdgeInsets.only(left:4.w,top: 15.h),
    child: Card(
      elevation:1,shadowColor:dark? TColors.white : TColors.black,
      child: Container(height: 60.h, width: 125.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp), color:dark? TColors.dark:Colors.grey.shade200),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
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

            Image.asset(TImages.pastTestImage,height:40,width:40)
            //Image.asset("")
          ],
        ),
      ),
    ),
  );
}
