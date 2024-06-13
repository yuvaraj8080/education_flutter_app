import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../constants/colors.dart';
import '../../../../../utils/halpers/helper_function.dart';
import '../../../controllers/onboarding/onboardingcontroller.dart';

class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunction.isDarkMode(context);
    final controller = onBordingController.instance;

    return Positioned(
        bottom:kToolbarHeight+20,
        left:30,
        child:SmoothPageIndicator(
          controller:controller.pageCotroller,
          onDotClicked: controller.dotNavigationClick,
          count:3,
          effect:ExpandingDotsEffect(activeDotColor: dark? TColors.light : TColors.primaryColor,dotHeight:5),
        ));
  }
}
