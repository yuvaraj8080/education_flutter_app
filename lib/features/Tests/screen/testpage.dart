
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';

import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';
import 'package:flutter_job_app/features/Tests/models/Utils.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/models/testpageWidgets.dart';
import 'package:flutter_job_app/features/Tests/screen/scorecard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../common/Login_Widgets/TSection_Heading.dart';

class Testpage extends StatefulWidget {
  final String batchName;
  final String weekNumber;
  final String topic;

  const Testpage(
      {super.key, required this.batchName, required this.weekNumber,required this.topic});

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  QuerySnapshot? querySnapshot;
  TimerController _timerController = Get.put(TimerController(onFinish: () {}));
  bool _dataLoaded = false;
  List<String> selectedAnswers = [];
  int totalMarksScored = 0;
  int _totalQuestions = 0;
  bool _canNavigate = false;

  Stream<QuerySnapshot>? questionStream;
  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _timerController = Get.put(TimerController(onFinish: () {}));
    getQuestions().then((_) async {
      setState(() {
        _dataLoaded = true;
      });
    });
  }

  Future<void> getQuestions() async {
    questionStream = await databaseService.getSubjectQuestions(
        widget.batchName, widget.weekNumber);

    DocumentSnapshot weekDoc = await databaseService.getWeekDocument(
        widget.batchName, widget.weekNumber);
    int duration = int.parse(weekDoc["duration"]);
    if (mounted) {
      questionStream!.listen((snapshot) {
        setState(() {
          selectedAnswers.clear();
          for (int i = 0; i < snapshot.docs.length; i++) {
            selectedAnswers.add('');
          }
          _timerController.startTimer(duration);
        });
      });
    }
  }

  void resetScoreForQuestion(
      int index, String newAnswer, String correctOption) {
    if (selectedAnswers[index] == correctOption) {
      totalMarksScored--;
    }
    selectedAnswers[index] = newAnswer;

    if (newAnswer == correctOption) {
      totalMarksScored++;
    }
  }

  PageController controller = PageController();

  Widget buildQuestion(DocumentSnapshot ds, int index, int totalQuestions) {
    String correctOption = ds["Correct Option"];
    List<String> options = [
      ds["Option1"],
      ds["Option2"],
      ds["Option3"],
      ds["Option4"]
    ];
    String selectedAnswer = selectedAnswers[index];

    return Column(
      children: [

        Testbanner(context, widget.weekNumber, widget.topic) ,
        SizedBox(height: 10.h,),
        Obx(() =>  Padding(
          padding:  EdgeInsets.only(right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TSectionHeading(context, ' ${_timerController.duration} remaining',size: 14.sp),
            ],
          ),
        ),),//' ${_timerController.duration} remaining'
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              TSectionHeading(context,'Q ',size:24.sp  ),
              Question(ds["Image"]),
            ],
          ),
        ),
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
        GestureDetector(
          onTap: () async{
            setState(() {});
            if (index == totalQuestions - 1) {
              _timerController.stopTimer();
               QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Tests').doc(widget.batchName).collection("weeks").doc(widget.weekNumber).collection("Question set").get();
              if (querySnapshot != null) {
                Get.off(Scorecard(
                  totalMarksScored: totalMarksScored,
                  totalQuestions: _totalQuestions,
                  questions: querySnapshot!.docs,
                  selectedAnswers: selectedAnswers,
                  weeknumber: widget.weekNumber,
                  topicname: widget.topic,
                ));
              } else {
                print("querySnapshot is null");
              }
            } else {
              controller.nextPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            }
          },
          child: index == totalQuestions - 1
              ? Utils().ElevatedButton("Submit",TColors.redtext)
              : Utils().ElevatedButton("Proceed To Next Question",TColors.green),
        ),
         
         underlinedText("view attempted questions") 
        
      ],
    );
  }




   Future<bool> _onWillPop() async {
    _timerController.stopTimer();
    Get.find<TimerController>().dispose();
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to exit the test?'),
        content: Text('Your progress will not be saved.And your marks will be recorded as zero'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
void dispose() {
  _timerController.stopTimer();
  Get.find<TimerController>().dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return _dataLoaded
        ? WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
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
                      _totalQuestions =
                          querySnapshot.docs.length; // Update _totalQuestions
                      _timerController.onFinish = () {
                        Get.to(() => Scorecard(
                              totalMarksScored: totalMarksScored,
                              totalQuestions: _totalQuestions,
                              questions: querySnapshot.docs,
                              selectedAnswers: selectedAnswers,
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
            ),
        )
        : const Center(child: CircularProgressIndicator());
  }
}
