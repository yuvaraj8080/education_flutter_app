import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';
import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';
import 'package:flutter_job_app/features/Tests/models/Testsingleton.dart';
import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/models/testresult.dart';
import 'package:flutter_job_app/features/Tests/screen/chooseSection.dart';
import 'package:flutter_job_app/features/Tests/screen/questionStatus.dart';
import 'package:flutter_job_app/features/Tests/screen/scorecard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NumericalTestPage extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String topic;
  final String section;
  final int duration;

  NumericalTestPage({
    super.key,
    required this.batchName,
    required this.weekNumber,
    required this.topic,
    required this.section,
    required this.duration
  });

  @override
  _NumericalTestPageState createState() => _NumericalTestPageState();
}

class _NumericalTestPageState extends State<NumericalTestPage> {
  QuerySnapshot? querySnapshot;
  final TimerController _timerController = Get.find<TimerController>();
  bool _dataLoaded = false;
  int totalQuestions=0;
 // List<String> userAnswers = [];
  final TestResultSingleton _testResultSingleton =
      TestResultSingleton.getInstance();

  Stream<QuerySnapshot>? questionStream;

  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    // widget.timerController = TimerController(onFinish: () {});
    getQuestions().then((_) async {
      setState(() {
        _dataLoaded = true;
      });
    });
  }

  Future<void> getQuestions() async {
    questionStream = await databaseService.getSubjectQuestions(
      widget.batchName,
      widget.weekNumber,
      widget.section,
    );
    QuerySnapshot<Object?> snapshot = await questionStream!.first;
    print(
        'Before update: _testResult.totalQuestions = ${_testResultSingleton.testResult.totalQuestions}');
    _testResultSingleton.testResult.totalQuestions += snapshot.docs.length;
    print(
        'After update: _testResult.totalQuestions = ${_testResultSingleton.testResult.totalQuestions}');
    DocumentSnapshot weekDoc = await databaseService.getWeekDocument(
        widget.batchName, widget.weekNumber, widget.section);
    totalQuestions=snapshot.docs.length;    

    int duration = weekDoc["duration"];
    if (mounted) {
      questionStream!.listen((snapshot) {
        setState(() {
          _testResultSingleton.testResult.numericalAnswers.clear();
          for (int i = 0; i < snapshot.docs.length; i++) {
           _testResultSingleton.testResult.numericalAnswers.add('');
          }
          // widget.timerController.startTimer(duration);
        });
      });
    }
  }

  void resetScoreForQuestion(
      int index, String newAnswer, String correctAnswer) {
    if ( _testResultSingleton.testResult.numericalAnswers[index] == correctAnswer) {
      // If the previous answer was correct, decrement the correct count
      _testResultSingleton.testResult.totalCorrectAnswers--;
    } else if ( _testResultSingleton.testResult.numericalAnswers[index] != '' &&
         _testResultSingleton.testResult.numericalAnswers[index] != correctAnswer) {
      // If the previous answer was wrong, decrement the wrong count
      _testResultSingleton.testResult.totalWrongAnswers--;
    }

    _testResultSingleton.testResult.numericalAnswers[index] = newAnswer;

    if (newAnswer == correctAnswer) {
      // If the new answer is correct, increment the correct count
      _testResultSingleton.testResult.totalCorrectAnswers++;
    } else if (newAnswer != '' && newAnswer != correctAnswer) {
      // If the new answer is wrong, increment the wrong count
      _testResultSingleton.testResult.totalWrongAnswers++;
    }
  }

  PageController controller = PageController();

  Widget buildQuestion(DocumentSnapshot ds, int index, int totalQuestions) {
    String correctAnswer = ds["Correct Option"];
    

    return SingleChildScrollView(
      child: Column(children: [
        // Test name banner
        Testbanner(context, widget.weekNumber, widget.topic),
        SizedBox(
          height: 10.h,
        ),
      
        // this part is for displaying remaining time
        Obx(
          () => Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TSectionHeading(
                    context, ' ${_timerController.timerDisplay} remaining',
                    size: 14.sp),
              ],
            ),
          ),
        ),
      
        // displaying question image
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              TSectionHeading(context, 'Q${index+1} ', size: 24.sp),
              Question(ds["Image"]),
            ],
          ),
        ),
      
        // this part is for displaying question and answer input field
        Column(
          children: [
            //  Text(question),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your answer',
              ),
              initialValue:  _testResultSingleton.testResult.numericalAnswers[index],
              onChanged: (newAnswer) {
                setState(() {
                  resetScoreForQuestion(index, newAnswer, correctAnswer);
                });
              },
            ),
          ],
        ),
      
        SizedBox(
          height: 200.h,
        ),
      
        // this part is for navigation to next question as well as scorecard
        GestureDetector(
          onTap: () async {
            setState(() {});
      
            if (index == totalQuestions - 1) {
             
              print(_testResultSingleton.testResult.numericalAnswers);
            Navigator.of(context).pop();
            } else {
              
              controller.nextPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
      
              );
            }
          },
          child: index == totalQuestions - 1
              ? Utils().ElevatedButton("Submit", TColors.redtext)
              : Utils().ElevatedButton("Proceed To Next Question", TColors.green),
        ),
        GestureDetector(
            onTap: () async {
              print("mcqanswers length:${_testResultSingleton.testResult.mcqAnswers.length}");
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      QuestionStatusPage(
                    selectedAnswers: _testResultSingleton.testResult.numericalAnswers,
                    totalQuestions:
                       totalQuestions,
                  ),
                ),
              );
            },
            child: underlinedText("view attempted questions"),
          ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _dataLoaded
          ? StreamBuilder<QuerySnapshot>(
              stream: questionStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return PageView.builder(
                      controller: controller,
                      itemCount: snapshot.data!.docs.length,
                      onPageChanged: (index) {
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return buildQuestion(
                            ds, index, snapshot.data!.docs.length);
                      },
                    );
                }
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
