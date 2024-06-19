
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Tests/models/Utils.dart';


import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/models/testpageWidgets.dart';
import 'package:flutter_job_app/features/Tests/screen/scorecard.dart';


class Testpage extends StatefulWidget {
  final String subject;

  const Testpage({super.key, required this.subject});

  @override
  State<Testpage> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage> {
  //for radio button
  bool _dataLoaded = false;
  String selectedvalue = '';
  List<String> selectedAnswers = [];
  int totalMarksScored = 0; // Store total marks

  Stream<QuerySnapshot>? questionStream;
  final databaseService DatabaseService = databaseService(); // Assuming you created the instance

  @override
  void initState() {
    super.initState();
    getQuestions().then((_) {
      setState(() {
        _dataLoaded = true;
      });
    });
  }

  Future<void> getQuestions() async {
    // Call the instance method using the instance variable
    questionStream = await DatabaseService.getSubjectQuestions(widget.subject);

    if (mounted) {
      questionStream!.listen((snapshot) {
        setState(() {
          selectedAnswers.clear();
          for (int i = 0; i < snapshot.docs.length; i++) {
            selectedAnswers.add('');
          }
        });
      });
    }
  }

  bool show = false;
  PageController controller = PageController();
  Widget buildAllQuestions() {
    return StreamBuilder<QuerySnapshot>(
      stream: questionStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Display error message
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          default:
            return PageView.builder(
                // ... your PageView implementation using snapshot.data!.docs
                controller: controller,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  String correctOption = ds["Correct Option"];
                  List<String> options = [
                    ds["Option1"],
                    ds["Option2"],
                    ds["Option3"],
                    ds["Option4"]
                  ];
                  String selectedAnswer = '';
                  if (index < selectedAnswers.length) {
                    selectedAnswer = selectedAnswers[index];
                  }
                  void resetScoreForQuestion(int index,String newAnswer) {
                    if (selectedAnswers[index] == correctOption) {
                      totalMarksScored--;
                    }
                    selectedAnswers[index] = newAnswer;
                  }

                  return Column(
                    children: [
                      Column(
                        children: [
                          //Question Image
                          Question(ds["Image"]),
                          //option 1
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade300,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    options[0],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Radio(
                                  key: ValueKey(options[0]),
                                  value: options[0],
                                  groupValue: selectedAnswers[index],
                                  onChanged: (currentvalue) {
                                    setState(() {
                                      // Update selected answer for this question
                                      resetScoreForQuestion(index, currentvalue!);

                                      // Check if selected value matches correct option and update totalMarksScored
                                      if (currentvalue == correctOption) {
                                        totalMarksScored++;
                                      } 
                                    });
                                  },
                                )
                              ],
                            ),
                          ),

                          //option 2

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade300,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    options[1],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Radio(
                                  key: ValueKey(options[1]),
                                  value: options[1],
                                  groupValue: selectedAnswers[index],
                                  onChanged: (currentvalue) {
                                    setState(() {
                                      // Update selected answer for this question
                                     resetScoreForQuestion(index, currentvalue!);

                                      // Check if selected value matches correct option and update totalMarksScored
                                      if (currentvalue == correctOption) {
                                        totalMarksScored++;
                                      } 
                                    });
                                  },
                                )
                              ],
                            ),
                          ),

                          //option3

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade300,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    options[2],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Radio(
                                  key: ValueKey(options[2]),
                                  value: options[2],
                                  groupValue: selectedAnswers[index],
                                  onChanged: (currentvalue) {
                                    setState(() {
                                      // Update selected answer for this question
                                      resetScoreForQuestion(index, currentvalue!);

                                      // Check if selected value matches correct option and update totalMarksScored
                                      if (currentvalue == correctOption) {
                                        totalMarksScored++;
                                      } 
                                    });
                                  },
                                )
                              ],
                            ),
                          ),

                          //Option4

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade300,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    options[3],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Radio(
                                  key: ValueKey(options[3]),
                                  value: options[3],
                                  groupValue: selectedAnswers[index],
                                  onChanged: (currentvalue) {
                                    setState(() {
                                      // Update selected answer for this question
                                     resetScoreForQuestion(index, currentvalue!);

                                      // Check if selected value matches correct option and update totalMarksScored
                                      if (currentvalue == correctOption) {
                                        totalMarksScored++;
                                      } 
                                    });
                                  },
                                )
                              ],
                            ),
                          ),

                          // Next question button

                          GestureDetector(
                              onTap: () {
                                setState(() {});
                                if (index == snapshot.data!.docs.length - 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Scorecard(
                                        totalMarksScored: totalMarksScored,
                                        totalQuestions:
                                            snapshot.data!.docs.length,
                                      ),
                                    ),
                                  );
                                } else {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                }
                              },
                              child: index == snapshot.data!.docs.length
                                  ? Utils().ElevatedButton("Submit")
                                  : Utils().ElevatedButton("Submit"))
                        ],
                      )
                    ],
                  );
                });
        }
      },
    );
  }

  // Widget buildScorecard() {
  //   return Column(
  //     children: [
  //       Text('Your Score: $totalMarksScored/${widget.questionStream.docs.length}'),
  //       Text('Your Answers:'),
  //       ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: selectedAnswers.length,
  //         itemBuilder: (context, index) {
  //           return Text(
  //             'Question ${index + 1}: ${selectedAnswers[index]}',
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget buildSummary(
  //     DocumentSnapshot ds, AsyncSnapshot<QuerySnapshot> snapshot) {
  //   if (snapshot.hasData) {
  //     // Data available, display summary
  //     return Column(
  //       children: [
  //         Text('Your Answers:', style: TextStyle(fontSize: 18)),
  //         ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: selectedAnswers.length,
  //           itemBuilder: (context, index) {
  //             return Text(
  //               'Question ${index + 1}: ${selectedAnswers[index]}',
  //             );
  //           },
  //         ),
  //         Text(
  //           'Total Marks Scored: $totalMarksScored',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return const Text('Loading...'); // Display placeholder while waiting
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: buildAllQuestions(), // Use the separate method for readability
    );
  }
}
