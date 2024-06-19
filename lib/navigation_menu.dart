import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Batches/Batches_Screen.dart';
import 'package:flutter_job_app/features/Home/screens/Home_Screen.dart';
import 'package:flutter_job_app/features/Tests/screen/Test_Screen.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';
import 'features/personalization/screens/setting.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(bottomNavigationBar: Obx(
          () => NavigationBar(
              height: 60,
              backgroundColor:THelperFunction.isDarkMode(context)?TColors.dark:Colors.grey.shade200,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(icon: Icon(Icons. people), label: "Batches"),
                NavigationDestination(icon: Icon(Icons.telegram), label: "Tests"),
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

  final Rx<int> selectedIndex = 0.obs;
  final screens = [

    const HomeScreen(),
    const BatchesScreen(),
    const TestScreen(),
    SettingScreen(userId:uid)

  ];
}
