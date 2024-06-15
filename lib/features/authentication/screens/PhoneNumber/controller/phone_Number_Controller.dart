

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
  void phoneAuthentication(String phoneNo)async {

    try{
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
    catch(e){
      TLoaders.errorSnackBar(title:"Oh snap",message:e.toString());
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

