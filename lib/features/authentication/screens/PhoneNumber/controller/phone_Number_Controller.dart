import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job_app/features/Home/screens/Home_Screen.dart';
import 'package:get/get.dart';
import '../../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../../utils/exceptions/format_exceptions.dart';
import '../../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../../utils/loaders/snackbar_loader.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../widgets/verificationNumber.dart';
class PhoneNumberController extends GetxController{
  static PhoneNumberController get instance => Get.find();


  TextEditingController phoneNumber = TextEditingController();
  var code = '';


  /// SENT OTP CODE ON MOBILE NUMBER
  sendCode() async{
    try{

      await FirebaseAuth.instance.verifyPhoneNumber(

        phoneNumber:"+91${phoneNumber.text}",

          verificationCompleted:(PhoneAuthCredential credential){},

          /// FIREBASE EXCEPTION HANDLING
          verificationFailed:(FirebaseAuthException e){
            TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
          },

          /// SENT OTP ON THE USER MOBILE NUMBER
          codeSent:(String vid, int? token){
            Get.to(VerifyNumberScreen(vid:vid,));
          },

          /// CODE EXPIRE AFTER LOGIN
          codeAutoRetrievalTimeout:(vid){}
      );
    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
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