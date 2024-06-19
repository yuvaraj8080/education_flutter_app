
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Tests/models/category_widgets.dart';
import 'package:flutter_job_app/features/Tests/screen/testpage.dart';

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
          GestureDetector(child: category("physics"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Testpage(subject: "Physics",))),),
          GestureDetector(child: category("chemistry"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Testpage(subject: "Chemistry",))),),
          GestureDetector(child: category("maths"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Testpage(subject: "Maths",))),),
          GestureDetector(child: category("biology"),onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Testpage(subject: "Biology",))),),
        ]
      ),

    );
  }
}
