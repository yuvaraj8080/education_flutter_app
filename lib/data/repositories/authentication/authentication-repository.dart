import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_job_app/utils/loaders/snackbar_loader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../features/authentication/screens/Login/login.dart';
import '../../../features/authentication/screens/onBoarding/onboarding.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  ///---VARIABLES----
  var verificationId = "".obs;
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;


  // GET AUTHENTICATED USER DATA
  User? get authUser => _auth.currentUser;


  /// CALLED FROM MAIN DART ON APP LAUNCH
   @override
  void onReady(){
     //REMOVE THE NATIVE SPLASH SCREEN
     FlutterNativeSplash.remove();
     //REDIRECT TO THE APPROPRITE SCREEN
     screenRedirect();
   }

   ///----FUNCTION TO SHOW RELEVANT SCREEN
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null ) {

      /// CURRENT USER IS AUTHORIZED THEN PASS TO THE BOTTOM NEVIGATION SCREEN
      Get.offAll(() => NavigationMenu());

    } else {
      // No user is signed in
      deviceStorage.writeIfNull("IsFirstTime", true);

      // Check if it's the first time launching the app
      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }


  /// PHONE AUTHENTICATION FUNCTION
  Future<void> sentOTPVerification(String phoneNo) async {
    try {

      String phoneNumber = '+91$phoneNo';
      TLoaders.customToast(message: "OTP successfully sent");

      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (credential) async {
            await _auth.signInWithCredential(credential);
          },
          codeSent: (verificationId, resendToken) {
            this.verificationId.value = verificationId;
          },
          codeAutoRetrievalTimeout: (verificationId) {
            this.verificationId.value = verificationId;
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-verification-id') {
              TLoaders.errorSnackBar(title: "Oh Snap", message: "Invalid phone number format.");
            } else {
              TLoaders.errorSnackBar(title: "Oh Snap", message: e.message ?? "Verification failed.");
            }
          }
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }



  /// VERIFICATION MOBILE NUMBER OTP
  Future<bool> verifyOTP(String otp) async {
    if (verificationId.value == null) {
      throw Exception("Verification ID is null");
    }
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value!,
            smsCode: otp
        )
    );
    return credentials.user != null ? true : false;
  }




  ///-------------EMAIL & PASSWORD SIGN-IN--------------------
  /// [EMAIL AUTHENTICATION ] - LOGIN
   Future<UserCredential> loginWithEmailAndPassword(String email, String password)async{
     try{
       return await _auth.signInWithEmailAndPassword(email: email, password: password);
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
       throw "Something went wrong, Please try again";
     }
   }

  /// [EMAIL VERIFICATION] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async{
    try{
     await _auth.currentUser?.sendEmailVerification();
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
      throw "Something went wrong, Please try again";
    }
  }


  /// [EmailAuthCredential] ---FORGOT PASSWORD--
  Future<void>sendPasswordResetEmail(String email)async{
    try{
      await _auth.sendPasswordResetEmail(email:email);
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
      throw "Something went wrong, Please try again";
    }
  }


  ///[ REAUTHENTICATE] - REAUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async{
     try{
       // CREATE A CREDENTIAL
       AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

       // REAUTHENTICATE
       await _auth.currentUser!.reauthenticateWithCredential(credential);

     } on FirebaseAuthException catch (e){
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
       throw "Something went wrong, Please try again";
     }
  }



  ///-------------------FEDERATED IDENTITY & SOCIAL SIGN IN ------------------]




  ///[Logout]- VALID FOR ANY AUTHENTICATION.

  Future <void> logout() async {
     try{
       await FirebaseAuth.instance.signOut();
       Get.offAll(()=> const LoginScreen());
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
       throw "Something went wrong, Please try again";
     }

  }


  ///  DELETE USER - REMOVE USER AUTH AND FIRESTORE ACCOUNT
  Future<void> deleteAccount() async {
     try{
       await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
       await _auth.currentUser?.delete();
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
       throw "Something went wrong, Please try again";
     }
  }
}
