import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/authentication/authentication-repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///SEND EMAIL VERIFICATION VERIFY SCREEN APPEAR & SET TIMER FOR AUTO REDIRECT
  @override
  void onInit() {
    sendEmailVerification();
    super.onInit();
  }

  // Send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        print("Error sending email verification: $e");
      }
    }
  }
}
