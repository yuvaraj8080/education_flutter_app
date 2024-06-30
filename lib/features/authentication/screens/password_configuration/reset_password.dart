import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login/forget_password_controller.dart';
import '../Login/login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions:[
              IconButton(onPressed: ()=>Get.offAll(()=> const LoginScreen()), icon:const Icon(CupertinoIcons.clear)),
            ]),
        body: SingleChildScrollView(
          child:Padding(padding: const EdgeInsets.only(top:100,right:32,left:32,bottom: 32),
              child:Column(
                  children:[

                    /// Asset Image  hare
                    const Image(image: AssetImage("assets/images/animations/emailVerificatation1.png")),
                    const SizedBox(height:50),

                    ///Email, title ans subtitle
                    Text(email,style:Theme.of(context).textTheme.bodyMedium,textAlign:TextAlign.center),
                    const SizedBox(height:8),
                    Text("Password Reset Email Sent",style:Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox(height:20),
                    Text("Your Account Security is Our Priority! We've Sent you a Secure link to safety change Your Password and Keep your Account Protected.",
                      style:Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height:50),


                    /// Calling the Successfully Verification Screen and Arguments
                    SizedBox(width:double.infinity,child: ElevatedButton(
                        onPressed:()=> Get.offAll(()=> const LoginScreen()),child:const Text("Done"),
                        )),


                        ///  Buttons and TextButtons
                    const SizedBox(height:20),
                    SizedBox(width:double.infinity,
                        child: TextButton(
                            onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                        child:const Text("Resend Email")))
                  ])
          ),
        )
    );
  }
}
