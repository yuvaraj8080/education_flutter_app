
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/constants/sizes.dart';

import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/scorecard_widgets.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';



import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/widgets_login/appBar/appbar.dart';

class completedScorecard extends StatefulWidget {
  int totalCorrectAnswers;
  int totalquestionsSkipped;
  int totalWrongAnswers;
  int totalQuestions;

  final String weeknumber;
  final String topicname;
  final String Timetaken;

  completedScorecard({
    required this.totalCorrectAnswers,
    required this.totalquestionsSkipped,
    required this.totalWrongAnswers,
    required this.totalQuestions, 
    required this.weeknumber,
    required this.topicname,
    required this.Timetaken
  });

  @override
  State<completedScorecard> createState() => _completedScorecardState();
}

class _completedScorecardState extends State<completedScorecard> {
  final controller = Get.put(UserController());
  // late  String studentID;
  // late String batchName;
  // late String name;
  @override
  void initState() {
     // studentID = controller.user.value.studentId;
     // batchName=controller.user.value.batch;
     // name=controller.user.value.fullName;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student = controller.user.value;
    return Scaffold(
        appBar: TAppBar(
          title: Text(widget.weeknumber, style: Theme.of(context).textTheme.titleLarge),
          showBackArrow: true,
          color:THelperFunction.isDarkMode(context)? TColors.dark : Colors.grey.shade200,
        ),
        //backgroundColor: TColors.green,
        body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.size12),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    TSectionHeading(context, widget.topicname,size:18),

                    SizedBox(
                      height: 30.h,
                    ),

                    StudentScoreCard(
                        context,
                        widget.totalQuestions,
                        widget.totalCorrectAnswers,
                        widget.totalquestionsSkipped,
                        widget.totalWrongAnswers,
                        student.studentId,
                        student.batch,
                        student.fullName,
                        widget.
                        Timetaken
                    ),
                    SizedBox(height:TSizes.appBarHeight56),

                    SizedBox(
                      width:double.infinity,
                      child: ElevatedButton(
                          onPressed:()=> Get.back(), child:Text("Back")),
                    ),
                  ]),
                ),
              )
        );
  }
}
