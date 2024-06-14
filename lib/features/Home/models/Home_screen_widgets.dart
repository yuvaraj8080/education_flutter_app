import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: TColors.primaryBackground,
    child: Column(
      children: [
        DrawerHeader(
            child: Center(
                child: Image.asset(
          "assets/images/chemisphere.png",
          height: 40,
        ))),
        Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text(
                  "H O M E",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CircularStd',
                      color: TColors.black),
                ),
                leading: const Icon(
                  Icons.home,
                  color: TColors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text(
                  "S E T T I N G S",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CircularStd',
                      color: TColors.black),
                ),
                leading: const Icon(
                  Icons.settings,
                  color: TColors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CircularStd',
                    color: TColors.black),
              ),
              leading: Icon(
                Icons.logout,
                color: TColors.black,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget whatsnewSection() {
  return Padding(
    padding: EdgeInsets.only(left: 29.w),
    child: Row(
      children: [
        Text(
          "What's new ? ",
          style:
          TextStyle(
              fontSize: 24.sp,
              color: TColors.black,
              fontFamily: 'CircularStd',
              fontWeight: FontWeight.w700),
        ),
        Image.asset(
          "assets/images/Eyes Emoji.png",
          height: 24.sp,
        ),
      ],
    ),
  );
}

Widget banner() {
  return Padding(
    padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
    child: SizedBox(
      height: 150.h,
      width: 342.w,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.asset("assets/images/jee adv1.jpg", fit: BoxFit.cover)),
    ),
  );
}

Widget reuseableText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 29.w, top: 20.h),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18.sp,
              color: TColors.black,
              fontFamily: 'CircularStd',
              fontWeight: FontWeight.w700),
        ),
      ),
    ],
  );
}

Widget ongoinglecture() {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10),
    child: Container(
      height: 55.h,
      width: 319.w,
      decoration: BoxDecoration(
          color: TColors.primaryBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 3,
              spreadRadius: 0,
              color: Colors.grey.shade300,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              "Join on going lecture",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'CircularStd',
                  color: TColors.redtext),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(
              "assets/images/live.gif",
              height: 40.h,
            ),
          )
        ],
      ),
    ),
  );
}

Widget reusableblocks(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w,top: 20,right: 20),
    child: Container(
      height: 60.h,
      width: 120.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.sp), color: TColors.dark),
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0),
                child: Text(text,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'CircularStd',
                    color: TColors.white),),
              ),
              const Icon(Icons.arrow_right_alt_rounded,color:  TColors.white,)
            ],
          ),
          //Image.asset("")
        ],
      ),
    ),
  );
}
