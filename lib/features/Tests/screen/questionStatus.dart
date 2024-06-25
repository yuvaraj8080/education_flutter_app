import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionStatusPage extends StatefulWidget {
  final List<String> selectedAnswers;
  final int totalQuestions;

  QuestionStatusPage({required this.selectedAnswers, required this.totalQuestions});
  @override
  _QuestionStatusPageState createState() => _QuestionStatusPageState();
}

class _QuestionStatusPageState extends State<QuestionStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body:  Column(
        children: [
          TSectionHeading(context, "Attempted Questions",size: 24.h),
          SizedBox(height: 20.h,),
      
          Padding(
            padding:EdgeInsets.all(10.w),
            child: SingleChildScrollView(
              child: GridView.count(
                  shrinkWrap: true, 
                crossAxisCount: 5,
                 childAspectRatio: 1.5,
                children: List.generate(widget.totalQuestions, (index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${index + 1}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.selectedAnswers[index]!= ''? Colors.green : Colors.red,
                        ),
                        width: 15,
                        height: 15,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}