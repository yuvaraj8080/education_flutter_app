
import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/Login_Widgets/TSection_Heading.dart';
import 'package:flutter_job_app/features/Tests/controllers/time_controller.dart';
import 'package:flutter_job_app/features/Tests/models/Week.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/create_test_widgets.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/screen/chooseSection.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TestListPage extends StatefulWidget {
 final String batchName;
  TestListPage({super.key,required this.batchName});


  @override
  _TestListPageState createState() => _TestListPageState();
}
class _TestListPageState extends State<TestListPage> {
  final DatabaseService _databaseService = DatabaseService();
  Future<List<Week>>? weeksFuture;

  @override
  void initState() {
    super.initState();
    weeksFuture = _databaseService.getWeeks(widget.batchName);
   // final TimerController timerController = Get.put(TimerController(onFinish: () {}));
  }

  @override
  Widget build(BuildContext context) {
    final TimerController timerController = Get.put(TimerController(onFinish: () {}));
    return Scaffold(
      appBar: AppBar(
        
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
              if (snapshot.data != null) {
                return Column(
                  children: [
                    TSectionHeading(context, "Ongoing tests for your batch:",size: 24.sp),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Week week = snapshot.data![index];
                        return GestureDetector(onTap: () => Get.to(()=>ChooseSection(batchName: widget.batchName,weekNumber:week.weekNumber,topic: week.topic,duration: week.duration,)/*Testpage(batchName: widget.batchName, weekNumber: week.weekNumber, topic: week.topic)*/),child: ongoingtest(week.weekNumber,week.topic));
                      },
                    ),
                  ],
                );
              } else {
                return Text('No Tests found');
              }
          }
        },
      ),
    );
  }
}