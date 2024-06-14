import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job_app/constants/image_string.dart';
import 'package:flutter_job_app/features/Home/screens/Home_Screen.dart';
import 'package:get/get.dart';
import '../../../../../common/NetworkManager/network_manager.dart';
import '../../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../../utils/exceptions/format_exceptions.dart';
import '../../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../../utils/loaders/snackbar_loader.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../widgets/verificationNumber.dart';
class PhoneNumberController extends GetxController{
  static PhoneNumberController get instance => Get.find();


   GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();
  var code = '';


  /// SENT OTP CODE ON MOBILE NUMBER
 sendCode() async {
  try {

     // START LOADING
     TFullScreenLoader.openLoadingDialog("Wait for OTP",TImages.codeLoadingAnimation);

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

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumber.text}",
      verificationCompleted: (PhoneAuthCredential credential) {},

      verificationFailed: (FirebaseAuthException e) {
        // Convert stack trace to string
        TFullScreenLoader.stopLoading();
        String errorMessage = e.stackTrace?.toString() ?? 'Unknown error';
        TLoaders.errorSnackBar(title: "Oh Snap", message: errorMessage);
      },

      codeSent: (String vid, int? token) {
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message:"OTP Sent sucessfully");
        Get.to(VerifyNumberScreen(vid: vid));
        

      },
      codeAutoRetrievalTimeout: (vid) {},
    );
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
  }
}

  


  /// SIGN IN WITH PHONE NUMBER FUNCTION
  signInWithPhoneNumber(String? verificationId) async{
    try{

      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId:verificationId!, smsCode:code);

      await FirebaseAuth.instance.signInWithCredential(credential).then((value)=> Get.offAll(const HomeScreen()));

    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
    }
  }
}