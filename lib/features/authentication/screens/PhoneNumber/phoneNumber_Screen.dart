import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/constants/sizes.dart';
import 'package:flutter_job_app/features/authentication/screens/PhoneNumber/widgets/phoneNumber_page.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/validators/validator.dart';
import 'controller/phone_Number_Controller.dart';
import 'widgets/verificationNumber.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PhoneNumberController.instance;
    return Scaffold(
      appBar:const TAppBar(showBackArrow: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// PHONE NUMBER PAGE UI
            const PhoneNumberPage(),

            /// PHONE NUMBER TEXT FROM FIELD
            const SizedBox(height: TSizes.size24),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller:controller.phoneNumber,
                validator: (value) => TValidator.validatePhoneNumber(value),
                decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Iconsax.mobile4, color: TColors.primaryColor),
                  labelText: "Enter your phone number",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            /// GET OTP BUTTON
            Padding(
              padding: const EdgeInsets.only(top:30,left:40,right:40),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(TColors.darkGrey)),
                  onPressed:()=> controller.sendCode(),
                  child: const Text("GET OTP"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
