import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/constants/sizes.dart';
import 'package:flutter_job_app/data/repositories/authentication/authentication-repository.dart';
import 'package:flutter_job_app/features/authentication/screens/PhoneNumber/controller/phone_Number_Controller.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/image_string.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var otp;
    final controller = Get.put(PhoneAuthenticationController());
    final resendOTP = Get.put(AuthenticationRepository());

    return Scaffold(
        appBar:TAppBar(showBackArrow:false,actions:[
          IconButton(onPressed:()=>Get.back(), icon:const Icon(Icons.clear,size:25))
        ],),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /// CHEMISPHERE PNG IMAGE
            SizedBox(
                width: 170,
                child: Image.asset(
                  TImages.Chemisphere,
                )),

            /// VERIFICATION PAGE TITLE HARE
            const SizedBox(height: 80),
            Text("Type the verification code",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            Text("That we have sent",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: 5),
            Text("Enter your verification code below",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),

            const SizedBox(height: 50),

            /// PIN PUT BOXES FOR CODE
            Pinput(
                mainAxisAlignment: MainAxisAlignment.center,
                length: 6,
                onChanged: (code) {
                  otp = code;
                  controller.verifyOTP(otp);
                }),


            /// EXPIRE AND RESEND OTP
                const SizedBox(height:TSizes.size12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Expires in 1:30",style:Theme.of(context).textTheme.bodyLarge),
                    OutlinedButton(onPressed:()=> resendOTP.sentOTPVerification(controller.phoneNo.text.trim()),
                        child:const Text("Resend OTP"))
                ]),

            ///  VERIFY TEXT BUTTON
            const SizedBox(height: 50),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(TColors.darkGrey)),
                onPressed: () => controller.verifyOTP(otp),
                child: const Text("VERIFY"),
              ),
            )
          ]),
        ));
  }
}
