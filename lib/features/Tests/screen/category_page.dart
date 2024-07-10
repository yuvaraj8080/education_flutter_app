
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Tests/Helping_widgets/category_widgets.dart';
import 'package:flutter_job_app/features/Tests/screen/OngoingTest.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class Test_Screen extends StatelessWidget {
  const Test_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title:const Text("Select the category"),
      ),
     body: GridView.count(
        crossAxisCount: 2, // Two items per row
        children: [
        //   GestureDetector(child: category("JEE/11th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestListPage(batchName: "JEE 11th"))),),
        //   GestureDetector(child: category("JEE/12th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestListPage(batchName: "JEE 12th"))),),
        //   GestureDetector(child: category("NEET/11th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestListPage(batchName: "NEET 11th"))),),
        //   GestureDetector(child: category("NEET/12th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestListPage(batchName: "NEET 12th"))),),
        // ]
  ]),

    );
  }
}
