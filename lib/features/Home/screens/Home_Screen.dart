import 'package:flutter/material.dart';


import 'package:flutter_job_app/features/Home/models/Home_screen_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(AuthenticationRepository());
    return Scaffold(
        // appBar:TAppBar(title:const Text("Chemisphere"),actions: [
        //   IconButton(onPressed:controller.logout, icon:const Icon(Icons.logout))
        // ],),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        // ),
        drawer: drawer(),
        body: Column(
          children: [
            SizedBox(
              height: 79.h,
            ),
            //drawer and profile component
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                  SizedBox(
                    width: 32.w,
                    height: 32.h,
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    //Image.asset("assets/images/"),
                  ),
                ],
              ),
            ),


            SizedBox(
              height: 36.h,
            ),
            //What's new section
            whatsnewSection(),
            banner(),
            reuseableText("What are you looking for?"),
            ongoinglecture(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                reusableblocks("Past test"),
                reusableblocks("Past test"),
              ],
            )

          ],
        ));
  }
}
