import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/colors.dart';
import '../../features/authentication/screens/Login/login_controller.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: ()=> controller.googleSignIn(),
            icon: const Image(
                width: 30,
                height: 30,
                image: AssetImage("assets/logos/googleLogo.png"))),
      ),
      const SizedBox(width: 15),
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: 30,
                height: 30,
                image: AssetImage("assets/logos/facebookLogo1.png"))),
      ),
    ]);
  }
}
