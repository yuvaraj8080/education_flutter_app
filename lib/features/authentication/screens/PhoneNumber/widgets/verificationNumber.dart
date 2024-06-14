import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/features/authentication/screens/PhoneNumber/controller/phone_Number_Controller.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_string.dart';

class VerifyNumberScreen extends StatelessWidget {
  const VerifyNumberScreen({super.key,required this.vid});

  final String vid;

  @override
  Widget build(BuildContext context) {

    final controller = PhoneNumberController.instance;

    return  Scaffold(

        appBar: const TAppBar(showBackArrow: true),
        body: Padding(
          padding: const EdgeInsets.only(left:20,right:20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            /// CHEMISPHERE PNG IMAGE
            SizedBox(width:170,child: Image.asset(TImages.Chemisphere,)),

            /// VERIFICATION PAGE TITLE HARE
            const SizedBox(height:50),
            Text("Type the verification code",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            Text("That we have sent",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height:5),
            Text("Enter your verification code below",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),

            /// PIN PUT BOXES FOR CODE
                Center(
                    child:Pinput(
                      length:6,
                      onChanged:(value){
                        controller.code = value;
                      }
                    )
                ),

            ///  VERIFY TEXT BUTTON
                Padding(
                  padding: const EdgeInsets.only(top:50,left:40,right:40),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          WidgetStateProperty.all<Color>(TColors.darkGrey)),
                      onPressed:()=> controller.signInWithPhoneNumber(vid),
                      child: const Text("VERIFY"),
                    ),
                  ),
                )

          ]),
        ));
  }
}
