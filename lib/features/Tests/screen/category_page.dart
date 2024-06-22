
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Tests/models/category_widgets.dart';
import 'package:flutter_job_app/features/Tests/screen/CreateTestList.dart';

// ignore: camel_case_types
class category_page extends StatelessWidget {
  const category_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Select the category"),
      ),
     body: GridView.count(
        crossAxisCount: 2, // Two items per row
        children: [
          GestureDetector(child: category("JEE/11th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestListPage(batchName: "JEE 11th"))),),
          GestureDetector(child: category("JEE/12th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestListPage(batchName: "JEE 12th"))),),
          GestureDetector(child: category("NEET/11th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestListPage(batchName: "NEET 11th"))),),
          GestureDetector(child: category("NEET/12th"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestListPage(batchName: "NEET 12th"))),),
        ]
      ),

    );
  }
}
