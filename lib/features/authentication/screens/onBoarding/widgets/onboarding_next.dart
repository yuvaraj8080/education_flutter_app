import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/authentication/controllers/onboarding/onboardingcontroller.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../constants/colors.dart';
import '../../../../../utils/halpers/helper_function.dart';


class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Positioned(
        right:30,
        bottom:kToolbarHeight,
        child:ElevatedButton(style: ElevatedButton.styleFrom(
            shape:const CircleBorder(),shadowColor:dark? Colors.white:Colors.black,elevation:3,
            backgroundColor:TColors.primaryColor),
            onPressed:() => onBordingController.instance.nextPage(),
            child:const Icon(Iconsax.arrow_right_3)));
  }
}
