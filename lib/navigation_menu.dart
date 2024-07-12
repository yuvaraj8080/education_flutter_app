import 'package:badges/badges.dart' as badges;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Batches/Batches_Screen.dart';
import 'package:flutter_job_app/features/Home/screens/Home_Screen.dart';
import 'package:flutter_job_app/features/Tests/models/database.dart';
import 'package:flutter_job_app/features/Tests/screen/OngoingTest.dart';

import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter_job_app/features/personalization/screens/profile.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
              height: 60,
              backgroundColor: THelperFunction.isDarkMode(context)
                  ? TColors.dark
                  : Colors.grey.shade200,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.people), label: "Batches"),
                NavigationDestination(
                  icon: Stack(
                    children: [
                      Icon(Icons.telegram),
                      GetX<NavigationController>(
                        builder: (controller) {
                          return   controller.remainingTestsCount.value!=0? Positioned(
                            top:-7,
                            right:-1,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                
                                shape: BoxShape.circle
                              ),
                              child: Text(
                                '${controller.remainingTestsCount.value}',
                                style: TextStyle(
                                    color: Colors.white, fontSize:16),
                              ),
                            ),
                          ):Icon(Icons.telegram_sharp);
                        },
                      ),
                    ],
                  ),
                  label: "Tests",
                ),
                NavigationDestination(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? userId = _auth.currentUser;
final String uid = userId!.uid;

class NavigationController extends GetxController {
  
  final DatabaseService _databaseService = DatabaseService();

  final Rx<int> selectedIndex = 0.obs;
  final Rx<int> remainingTestsCount = 0.obs;
  final screens = [
    const HomeScreen(),
    const BatchesScreen(),
    OngoingTestPage(),
    ProfileScreen()
  ];

  @override
  void onInit() {
   
    super.onInit();
   Get.find<UserController>().user.listen((user) {
    if (user != null) {
      fetchRemainingTestsCount();
    }
  });
  }
   void navigateToHome() {
    Get.off(NavigationMenu());
    fetchRemainingTestsCount();
  }

   void fetchRemainingTestsCount() async {
   
   
    int count = await _databaseService.fetchRemainingTestsCount();
     print('Remaining tests count: $count'); 
    remainingTestsCount.value = count;
   
  }
   
}
