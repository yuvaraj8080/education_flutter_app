

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/NetworkManager/network_manager.dart';
import '../../../../../constants/image_string.dart';
import '../../../../../data/repositories/authentication/authentication-repository.dart';
import '../../../../../utils/loaders/snackbar_loader.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../Home/screens/Home_Screen.dart';
import '../widgets/otp_verification.dart';

class PhoneAuthenticationController extends GetxController {
  static PhoneAuthenticationController get instance => Get.find();


  GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();



  /// PHONE AUTHENTICATION
  void phoneAuthentication(String phoneNo) async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog("Wait for OTP", TImages.OTPAnimation);

      // CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: "No internet connection");
        return;
      }

      // FORM VALIDATION
      if (!phoneNumberFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: "Invalid phone number");
        return;
      }

      // PHONE AUTHENTICATION
      await AuthenticationRepository.instance.phoneAuthentication(phoneNo);

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SUCCESS SCREEN
      TLoaders.customToast(message: "OTP successfully sent");

      // NAVIGATE TO THE OTP SCREEN
      Get.to(() => const OtpVerificationScreen());
    } catch (e, stackTrace) {
      // LOG ERROR WITH STACK TRACE
      debugPrint('Error during phone authentication: $e');
      debugPrintStack(stackTrace: stackTrace);

      // SHOW ERROR MESSAGE
      TLoaders.errorSnackBar(title: "Oh snap", message: e.toString());

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
    }
  }



  /// SENT OTP FUNCTION HARE
  void verifyOTP(String otp) async{

      /// START LOADING
      // TFullScreenLoader.openLoadingDialog("Wait for OTP",TImages.OTPAnimation);

      // CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        // TFullScreenLoader.stopLoading();/
        return;
      }

      var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);

      //  REMOVE LOADER
      // TFullScreenLoader.stopLoading();

      isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}

