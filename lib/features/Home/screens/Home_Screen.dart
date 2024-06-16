import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Home/models/Home_screen_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/Drawer_AppBar/Drawer_Widgets.dart';
import '../../../common/Login_Widgets/Home_Banner.dart';
import '../../../common/Login_Widgets/Past_OnlineTest.dart';
import '../../../common/Login_Widgets/TOnlineLectureSection.dart';
import '../../../common/Login_Widgets/TSection_Heading.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(),
        body: Padding(
          padding: const EdgeInsets.only(left:20,right:20),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),

              ///DRAWER AND PROFILE COMPONENTS
              const Drawer_AppBar(),

              SizedBox(height: 36.h),
              /// SECTION HEADING
              TSectionHeading(context,"Whats new? 👀"),

              /// HOME SCREEN BANNER
              SizedBox(height: 10.h),
              TSectionBanner(),

              /// HOME SCREEN HEADING
              Padding(
                padding: const EdgeInsets.only(left:10,top: 20),
                child: TSectionHeading(context,"What are you looking for?",size:18),
              ),

              /// ONLINE LACTURE SECTION
              TOnlineLectureSection(context),

              /// PAST ONLINE TEST
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TOnlinePastTest("Past tests",context,),
                  TOnlinePastTest("Past tests",context),
                ],
              )

            ],
          ),
        ));
  }
}

