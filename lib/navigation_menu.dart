import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/profile/sceens/profile_page.dart';
import 'package:get/get.dart';
import 'features/JobFeed/screens/jobs_screen.dart';
import 'features/JobPost/screens/search_companies.dart';
import 'features/JobPost/screens/upload_job.dart';
import 'features/personalization/screens/profile.dart';
import 'features/personalization/screens/setting.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(bottomNavigationBar: Obx(
          () => NavigationBar(
              height: 60,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_repair_service_sharp), label: "Jobs"),
                NavigationDestination(icon: Icon(Icons.search_rounded), label: "Search"),
                NavigationDestination(icon: Icon(Icons.add_a_photo_sharp), label: "Post"),
                NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
              ]),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}


final FirebaseAuth _auth = FirebaseAuth.instance;
final User? userId = _auth.currentUser;
final String uid = userId!.uid;

class NavigationController extends GetxController {

  //
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final User? userId = _auth.currentUser;
  // final String uid = userId!.uid;

  final Rx<int> selectedIndex = 0.obs;
  final screens = [

    const JobScreen(),
    const SearchCompany(),
    const UploadJob(),
    const ProfileScreen(userId: '')
    // const SettingScreen(userId:'')
  ];
}
