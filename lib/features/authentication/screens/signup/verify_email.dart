//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../data/repositories/authentication/authentication-repository.dart';
// import '../../controllers/signup/verify_email_controller.dart';
// class VerifyEmailScreen extends StatelessWidget {
//   const VerifyEmailScreen({super.key, this.email});
//
//   final String? email;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final controller = Get.put(VerifyEmailController());
//
//     return Scaffold(
//
//       appBar: AppBar(
//           automaticallyImplyLeading: false,
//           actions:[
//         IconButton(onPressed: ()=>AuthenticationRepository.instance.logout(), icon:const Icon(CupertinoIcons.clear)),
//       ]),
//       body: SingleChildScrollView(
//         child:Padding(padding: const EdgeInsets.only(top:100,right:32,left:32,bottom: 32),
//           child:Column(
//               children:[
//
//                 /// Asset Image  hare
//             const Image(image: AssetImage("assets/images/animations/emailVerificatation1.png")),
//             const SizedBox(height:50),
//
//             /// title ans subtitle
//             Text("Verify your email address!",style:Theme.of(context).textTheme.headlineMedium,),
//             const SizedBox(height:20),
//             Text(email??'',style:Theme.of(context).textTheme.labelLarge,textAlign:TextAlign.center),
//             const SizedBox(height:8),
//             Text("Congratulations! your Account Awaits: Verify Your Email to Start Shopping and Experience a world of Unrivaled Deals ans Personalized Offers",
//             style:Theme.of(context).textTheme.labelMedium,
//             ),
//                 const SizedBox(height:50),
//
//
//           /// Calling the Successfully Verification Screen and Arguments
//            SizedBox(width:double.infinity,child: ElevatedButton(
//                onPressed:()=>  controller.checkEmailVerificationStatus(),
//
//                ///  Buttons and TextButtons
//                child:const SizedBox(width: double.infinity,
//                    child: Center(child: Text("Continue"))))),
//            const SizedBox(height:20),
//            SizedBox(width:double.infinity,child: TextButton(onPressed:()=>controller.sendEmailVerification(), child:const Text("Resend Email")))
//
//               ])
//         ),
//       )
//     );
//   }
// }
