import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';

import '../../../controllers/onboarding/onboardingcontroller.dart';

class onBoardingSkip extends StatelessWidget {

  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top:kToolbarHeight,right:8,child:TextButton(
      onPressed:()=> onBordingController.instance.skipPage(),
      child: Text("Skip",style:Theme.of(context).textTheme.titleLarge?.copyWith(color:TColors.primaryColor)),));
  }
}
