import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication-repository.dart';

Widget drawer() {
  final controller = Get.put(AuthenticationRepository());
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
            },
            child:  ListTile(

              title: const Text(
                "L O G O U T",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CircularStd',
                    color: TColors.black),
              ),
              leading: IconButton(onPressed:()=> controller.logout(), icon:const Icon(Icons.logout))
            ),
          ),
        ),
      ],
    ),
  );
}