import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/image_string.dart';
import 'package:flutter_job_app/data/repositories/authentication/authentication-repository.dart';
import 'package:flutter_job_app/features/Home/screens/Home_Screen.dart';
import 'package:flutter_job_app/features/authentication/screens/PhoneNumber/widgets/otp_verification.dart';
import 'package:flutter_job_app/utils/loaders/snackbar_loader.dart';
import 'package:flutter_job_app/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

import '../../../../../common/NetworkManager/network_manager.dart';

class PhoneAuthenticationController extends GetxController {
  static PhoneAuthenticationController get instance => Get.find();


  GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();



  /// PHONE AUTHENTICATION
  void phoneAuthentication(String phoneNo)async {

    /// START LOADING
    TFullScreenLoader.openLoadingDialog("Wait for OTP",TImages.OTPAnimation);

    // CHECK INTERNET CONNECTIVITY
    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected){
      TFullScreenLoader.stopLoading();
      return;
    }

    // FORM VALIDATION
    if(!phoneNumberFormKey.currentState!.validate()){
      TFullScreenLoader.stopLoading();
      return;
    }

    AuthenticationRepository.instance.phoneAuthentication(phoneNo);

    //  REMOVE LOADER
    TFullScreenLoader.stopLoading();

    // SHOW SUCCESS SCREEN
    TLoaders.customToast(message: "OTP SuccessFully sent");

    /// NAVIGATE TO THE OTP SCREEN
    Get.to(()=> const OtpVerificationScreen());
  }


  /// SENT OTP FUNCTION HARE
  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}

