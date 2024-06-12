
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding/onboardingcontroller.dart';
import 'widgets/onBoarding_dot_navigation.dart';
import 'widgets/onboarding_next.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(onBordingController());

    return Scaffold(
        body: Stack(children: [
          /// Horizantal Scrollabel Pages
      PageView(
        controller: controller.pageCotroller,
          onPageChanged: controller.updatePageIndicator,
          children: const [

        onBordingPage(image:"assets/onboarding/onboarding1.gif",
          title: "WELCOME TO CHEMISPHERE",subtitle:"Get the best student experience with tons of new added features."),


        onBordingPage(image:"assets/onboarding/onboarding2.gif",
            title: "SECURE YOUR PAYMENTS",subtitle:"With our robust payment portal, keep and easy track of your fee."),

        onBordingPage(image:"assets/onboarding/onboarding3.gif",
            title: "STUDENT DASHBOARD",subtitle:"Launching an interactive dashboard for student"),
      ]),

          /// Skip Button
          const onBoardingSkip(),

          ///  Bot Navigation SmoothPageIndicator
          const onBoardingNavigation(),

          ///  Circular Button
          const onBoardingNextButton()

    ]));
  }
}





