// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../../../../common/widgets_login/success_Screee/sucess_screen.dart';
// import '../../../../data/repositories/authentication/authentication-repository.dart';
//
// class VerifyEmailController extends GetxController {
//   static VerifyEmailController get instance => Get.find();
//
//   ///SEND EMAIL VERIFICATION VERIFY SCREEN APPEAR & SET TIMER FOR AUTO REDIRECT
//   @override
//   void onInit() {
//     sendEmailVerification();
//     setTimerForAutoRedirect();
//     super.onInit();
//   }
//
//   // Send email verification link
//   sendEmailVerification() async {
//     try {
//       await AuthenticationRepository.instance.sendEmailVerification();
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error sending email verification: $e");
//       }
//     }
//   }
//
//   // Set timer for automatic redirection on email verification
//   setTimerForAutoRedirect() {
//     Timer.periodic(const Duration(seconds: 1), (timer) async {
//       await FirebaseAuth.instance.currentUser?.reload();
//       final user = FirebaseAuth.instance.currentUser;
//       if (user?.emailVerified ?? false) {
//         timer.cancel();
//         Get.off(() => SuccessScreen(
//             image: "assets/images/animations/doneEmail.webp",
//             title: "Your Account Successfully Created!",
//             subtitle: "Welcome to your Ultimate shopping Destination: your Account is Created, Unleash the jay of Seamless Online Shopping",
//             onPressed: () =>
//                 AuthenticationRepository.instance.screenRedirect()));
//       }
//     });
//   }
//
//   // Manually check if email verified
//   checkEmailVerificationStatus() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null && currentUser.emailVerified) {
//       showSuccessScreen();
//     }
//   }
//
//   // Show success screens after email verification
//   void showSuccessScreen() {
//     Get.offAll(() => SuccessScreen(
//           image: "assets/images/animations/emailVerificatation1.png",
//           title: "Congratulations!",
//           subtitle: "Your Email Successfully Verified",
//           onPressed: () => AuthenticationRepository.instance.screenRedirect(),
//         ));
//   }
// }
