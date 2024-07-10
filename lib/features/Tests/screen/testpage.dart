import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';
import 'package:flutter_job_app/features/Tests/models/Testsingleton.dart';

import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/testpageWidgets.dart';

import 'package:flutter_job_app/features/Tests/screen/questionStatus.dart';
import 'package:flutter_job_app/features/Tests/screen/scorecard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/Login_Widgets/TSection_Heading.dart';

class Testpage extends StatefulWidget {
  final String batchName; //fetches batch name from previous page
  final String weekNumber; //similar to above
  final String topic;
  final String section; //similar to above
  final int duration;
  Testpage(
      {super.key,
      required this.batchName,
      required this.weekNumber,
      required this.topic,
      required this.section,
      required this.duration});

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  QuerySnapshot? querySnapshot;
  final TimerController _timerController = Get.find<TimerController>();
  bool _dataLoaded = false;
  int totalQuestions = 0;
  final TestResultSingleton _testResultSingleton =
      TestResultSingleton.getInstance();

  int totalWrongAnswers = 0;

  Stream<QuerySnapshot>? questionStream; //initializing Stream
  final DatabaseService databaseService =
      DatabaseService(); //create an database service object

  @override
  void initState() {
    super.initState();
    // widget.timerController =
    //(TimerController(onFinish: () {})); //initializinng timercontroller
    getQuestions().then((_) async {
      setState(() {
        _dataLoaded = true;
      }); //it sets the dataloaded when all questions are available
    });
  }

  Future<void> getQuestions() async {
    questionStream = await databaseService.getSubjectQuestions(widget.batchName,
        widget.weekNumber, widget.section); //gets thhe list of questions
    QuerySnapshot<Object?> snapshot = await questionStream!.first;
    print(
        'Before update: _testResult.totalQuestions = ${_testResultSingleton.testResult.totalQuestions}');
    _testResultSingleton.testResult.totalQuestions += snapshot.docs.length;
    print(
        'After update: _testResult.totalQuestions = ${_testResultSingleton.testResult.totalQuestions}');
    DocumentSnapshot weekDoc = await databaseService.getWeekDocument(
        widget.batchName,
        widget.weekNumber,
        widget.section); //gets the test details
    totalQuestions = snapshot.docs.length;
    int duration = weekDoc["duration"];
    if (mounted) {
      questionStream!.listen((snapshot) {
        setState(() {
          _testResultSingleton.testResult.mcqAnswers.clear();
          for (int i = 0; i < snapshot.docs.length; i++) {
            _testResultSingleton.testResult.mcqAnswers.add('');
          } // addeds an empty string at each question index to tracck the selected answers
          //widget.timerController.startTimer(duration); //startinng the timer
        });
      });
    }
  }

  //this part adds the selected answer to thhe selected annswer array,also increment the marks if it matches with correct optionn
  void resetScoreForQuestion(
      int index, String newAnswer, String correctOption) {
    if (_testResultSingleton.testResult.mcqAnswers[index] == correctOption) {
      // If the previous answer was correct, decrement the correct count
      _testResultSingleton.testResult.totalCorrectAnswers--;
    } else if (_testResultSingleton.testResult.mcqAnswers[index] != '' &&
        _testResultSingleton.testResult.mcqAnswers[index] != correctOption) {
      // If the previous answer was wrong, decrement the wrong count
      _testResultSingleton.testResult.totalWrongAnswers--;
    }

    _testResultSingleton.testResult.mcqAnswers[index] = newAnswer;

    if (newAnswer == correctOption) {
      // If the new answer is correct, increment the correct count
      _testResultSingleton.testResult.totalCorrectAnswers++;
    } else if (newAnswer != '' && newAnswer != correctOption) {
      // If the new answer is wrong, increment the wrong count
      _testResultSingleton.testResult.totalWrongAnswers++;
    }
  }

  PageController controller = PageController();

  //this widget is for displaying the question and options

  Widget buildQuestion(DocumentSnapshot ds, int index, int totalQuestions) {
    String correctOption = ds["Correct Option"];
    List<String> options = [
      ds["Option1"],
      ds["Option2"],
      ds["Option3"],
      ds["Option4"]
    ];
    String selectedAnswer = _testResultSingleton.testResult.mcqAnswers[index];

    return Column(
      children: [
        // Test name banner
        Testbanner(context, widget.weekNumber, widget.topic),
        SizedBox(
          height: 10.h,
        ),

        // this part is for displaying remaininng time
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

        // displaying questionn image
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              TSectionHeading(context, 'Q${index + 1} ', size: 24.sp),
              Question(ds["Image"]),
            ],
          ),
        ),

        //this part is for displaying options
        ...options.map((option) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 50,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  activeColor: TColors.black,
                  key: ValueKey(option),
                  value: option,
                  groupValue: selectedAnswer,
                  onChanged: (currentValue) {
                    setState(() {
                      resetScoreForQuestion(
                          index, currentValue!, correctOption);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    option,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        //this  part is for navigation  to next question as well as scorecard
        GestureDetector(
          onTap: null, // Remove the onTap callback
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (index > 0) {
                    controller.previousPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),
              index == totalQuestions - 1
                  ? Utils().ElevatedButton("Proced to submit", TColors.redtext)
                  : Utils().ElevatedButton(
                      "Proceed To Next Question", TColors.green),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (index < totalQuestions - 1) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),
            ],
          ),
        ),

        GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    QuestionStatusPage(
                  selectedAnswers: _testResultSingleton.testResult.mcqAnswers,
                  totalQuestions: totalQuestions,
                ),
              ),
            );
          },
          child: underlinedText("view attempted questions"),
        ),
      ],
    );
  }

  void submitTest() {
    print(_testResultSingleton.testResult.mcqAnswers);
    print(_testResultSingleton.testResult.numericalAnswers);
    int totalSkippedMcqQuestions = _testResultSingleton.testResult.mcqAnswers
        .where((answer) => answer == '')
        .length;
    int totalSkippedNumericalQuestions = _testResultSingleton
        .testResult.numericalAnswers
        .where((answer) => answer == '')
        .length;
    int totalSkippedQuestions =
        totalSkippedMcqQuestions + totalSkippedNumericalQuestions;

    _testResultSingleton.testResult.totalSkippedQuestions =
        totalSkippedQuestions;
    print(_testResultSingleton.testResult.totalSkippedQuestions);
  }

  @override
  void dispose() {
    //_timerController.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _dataLoaded
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.batchName),
              automaticallyImplyLeading: false,
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: questionStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display error message
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show loading indicator
                  default:
                    QuerySnapshot querySnapshot = snapshot.data!;
                    _timerController.onFinish = () async {
                      QuerySnapshot numericalquerySnapshot =
                          await FirebaseFirestore.instance
                              .collection('Tests')
                              .doc(widget.batchName)
                              .collection("weeks")
                              .doc(widget.weekNumber)
                              .collection("section")
                              .doc('Numericalquestions')
                              .collection('QuestionSet')
                              .get();
                      submitTest();
                      String elapsedTime = _timerController.getElapsedTime();
                      Get.to(() => Scorecard(
                            Timetaken: elapsedTime,
                            numericalquestions: numericalquerySnapshot.docs,
                            questionsSkipped: _testResultSingleton
                                .testResult.totalSkippedQuestions,
                            testScore: _testResultSingleton.testResult,
                            mcqquestions: querySnapshot.docs,
                            mcqAnswers:
                                _testResultSingleton.testResult.mcqAnswers,
                            numericalAnswers: _testResultSingleton
                                .testResult.numericalAnswers,
                            weeknumber: widget.weekNumber,
                            topicname: widget.topic,
                          ));
                    };
                    return PageView.builder(
                      controller: controller,
                      itemCount: querySnapshot.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = querySnapshot.docs[index];
                        return buildQuestion(
                            ds, index, querySnapshot.docs.length);
                      },
                    );
                }
              },
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
