import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/Login_Widgets/Online_Test_Section.dart';
import '../../../common/Login_Widgets/TOnlineLectureSection.dart';
import '../../../common/Login_Widgets/TSection_Heading.dart';
import 'widget/Section_Banner.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// DRAWER HARE
        // drawer: drawer(),

        body: Padding(
          padding: const EdgeInsets.only(left:20,right:20),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),

              ///DRAWER AND PROFILE COMPONENTS
              // const Drawer_AppBar(),

              SizedBox(height: 36.h),
              /// SECTION HEADING
              TSectionHeading(context,"Whats new? 👀"),

              /// HOME SCREEN BANNER
              TSectionBanners(),

              /// HOME SCREEN HEADING
              Padding(
                padding: const EdgeInsets.only(left:10,top: 20),
                child: TSectionHeading(context,"What are you looking for?",size:18),
              ),

              /// ONLINE LACTURE SECTION
              TOnlineLectureSection(context),

              /// PAST TEST AND NOTES HARE
              SizedBox(height: 10.h),
              TOnlineTestSection(firstName: 'Past tests', lastName: 'Notes'),

              /// PYQ AND MY SCORES HARE
              TOnlineTestSection(firstName: 'PYQS', lastName: 'My Scores'),

            ],
          ),
        ));
  }
}



