import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/features/Tests/models/Week.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/create_test_widgets.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/screen/completedScorecard.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:get/get.dart';
import '../../../common/shimmers/box_shimmer.dart';

class TestScreen extends StatefulWidget {
  
  TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final DatabaseService _databaseService = DatabaseService();
  Future<List<Week>>? weeksFuture;
  Stream<QuerySnapshot<Object?>>? completedTestsStream;
   final controller = Get.put(UserController());
   late String _batch;
   
  @override
  void initState() {
    super.initState();
    _batch=controller.user.value.batch;
    weeksFuture = _databaseService.getWeeks(_batch);
    completedTestsStream = _databaseService
        .getCompletedTests(); // Get completed tests for the current student
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text("Completed Tests", style: Theme.of(context).textTheme.titleLarge),
        showBackArrow: true,
        color: dark ? TColors.dark : Colors.grey.shade200,
      ),
      body: FutureBuilder<List<Week>>(
        key: Key('weeks_future_builder'),
        future: weeksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return TBoxShimmer();
            default:
              if (snapshot.data != null) {
                List<Week> weeks = snapshot.data!;

                // Get completed tests for the current student
                return StreamBuilder<QuerySnapshot>(
                  stream: completedTestsStream,
                  builder: (context, completedTestsSnapshot) {
                    if (completedTestsSnapshot.hasError) {
                      return Text('Error: ${completedTestsSnapshot.error}');
                    }

                    switch (completedTestsSnapshot.connectionState) {
                      case ConnectionState.waiting:
                        return TBoxShimmer();
                      default:
                        if (completedTestsSnapshot.data != null) {
                          List<Week> ongoingTests = [];
                          List<Week> completedTests = [];

                          weeks.forEach((week) {
                            bool isCompleted = false;
                            completedTestsSnapshot.data!.docs.forEach((doc) {
                              if (doc.get('weekNumber') == week.weekNumber) {
                                isCompleted = true;
                              }
                            });

                            if (isCompleted) {
                              completedTests.add(week);
                            } else {
                              ongoingTests.add(week);
                            }
                          });

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: completedTests.length,
                                  itemBuilder: (context, index) {
                                    Week week = completedTests[index];
                                    int totalQuestions =
                                        0; // Initialize totalQuestions
                                    int totalCorrectAnswers =
                                        0; // Initialize totalCorrectAnswers
                                    int totalWrongAnswers =
                                        0; // Initialize totalWrongAnswers
                                    int totalSkippedQuestions =
                                        0; // Initialize totalSkippedQuestions
                                    String Timetaken='';
                                    // Get the completed test document from Firestore
                                    completedTestsSnapshot.data!.docs
                                        .forEach((doc) {
                                      if (doc.get('weekNumber') ==
                                          week.weekNumber) {
                                        totalQuestions =
                                            doc.get('totalQuestions');
                                        totalCorrectAnswers =
                                            doc.get('totalCorrectAnswers');
                                        totalWrongAnswers =
                                            doc.get('totalWrongAnswers');
                                        totalSkippedQuestions =
                                            doc.get('totalSkippedQuestions');
                                        Timetaken=doc.get('Timetaken');
                                      }
                                    });
                                    return GestureDetector(
                                      onTap: () => Get.to(
                                          completedScorecard(
                                          Timetaken: Timetaken,
                                          totalCorrectAnswers:
                                              totalCorrectAnswers,
                                          totalquestionsSkipped:
                                              totalSkippedQuestions,
                                          totalWrongAnswers: totalWrongAnswers,
                                          totalQuestions: totalQuestions,
                                          weeknumber: week.weekNumber,
                                          topicname: week.topic)),
                                      child: completedtest(
                                        week.weekNumber,
                                        week.topic,
                                        context
                                        // createdAt: week.createdAt.toDate().toString(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: Text('No Tests found'));
                        }
                    }
                  },
                );
              } else {
                return Center(child: Text('No Tests found'));
              }
          }
        },
      ),
    );
  }
}
