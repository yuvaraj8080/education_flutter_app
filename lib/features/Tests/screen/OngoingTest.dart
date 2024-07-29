import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/constants/colors.dart';

import 'package:flutter_job_app/features/Tests/models/Week.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/create_test_widgets.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/screen/chooseSection.dart';

import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:flutter_job_app/utils/shimmer_circular_Indicator/shimmer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OngoingTestPage extends StatefulWidget {
  OngoingTestPage({super.key});

  @override
  _OngoingTestPageState createState() => _OngoingTestPageState();
}

class _OngoingTestPageState extends State<OngoingTestPage> {
  final DatabaseService _databaseService = DatabaseService();
  Future<List<Week>>? weeksFuture;
  Stream<QuerySnapshot<Object?>>? completedTestsStream;
  final controller = Get.put(UserController());
  late String _batch;
  @override
  void initState() {
    super.initState();
    _batch = controller.user.value.batch;
    weeksFuture = _databaseService.getWeeks(_batch);
    completedTestsStream = _databaseService
        .getCompletedTests(); // Get completed tests for the current student
  }

  @override
  Widget build(BuildContext context) {
     final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text("Completed tests:", style: Theme.of(context).textTheme.headlineSmall),
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
              return Text('Loading....');
            default:
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Text(
                    'No Tests found'); // Show this when no tests are available
              } else {
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
                        return TShimmerEffect(width:double.infinity, height:double.infinity);
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

                          if (ongoingTests.isEmpty) {
                            return Center(
                              child: TSectionHeading(
                                        context, "No Test found",
                                        size: 20.sp),
                            ); // Display this when there are no ongoing tests
                          } else {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                              
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: ongoingTests.length,
                                    itemBuilder: (context, index) {
                                      Week week = ongoingTests[index];
                                      return GestureDetector(
                                        onTap: () => Get.to(() => ChooseSection(
                                              batchName: _batch,
                                              weekNumber: week.weekNumber,
                                              topic: week.topic,
                                              duration: week.duration,
                                            )),
                                        child: ongoingtest(
                                          week.weekNumber,
                                          week.topic,
                                          // createdAt: week.createdAt.toDate().toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return Text('No Tests found');
                        }
                    }
                  },
                );
              }
          }
        },
      ),
    );
  }
}
