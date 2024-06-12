
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../features/authentication/screens/Login/login.dart';
import '../../../features/authentication/screens/onBoarding/onboarding.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exception_handling/handle_exception_file.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  ///---VARIABLES----
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
    if (user != null) {
      // User is signed in
      if (user.emailVerified) {
        // Email is verified, navigate to the main screens
        Get.offAll(() => const NavigationMenu());
      } else {
        // Email is not verified, navigate to the VerifyEmailScreen
        Get.offAll(() => VerifyEmailScreen(email:_auth.currentUser?.email));
      }
    } else {
      // No user is signed in
      deviceStorage.writeIfNull("IsFirstTime", true);

      // Check if it's the first time launching the app
      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
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
       throw TFormException();
     }
     on PlatformException catch (e){
       throw TPlatformException(e.code).message;
     }
     catch(e){
       throw "Something went wrong, Please try again";
     }
   }


  ///[EMAIL AUTHENTICATION ] - REGISTER
  Future<UserCredential>registerWithEmailAndPassword(String email,String password)async{
     try{
       return await _auth.createUserWithEmailAndPassword(email:email, password:password);
     }
     on FirebaseAuthException catch (e){
       throw TFirebaseAuthException(e.code).message;
     }
     on FirebaseException catch (e){
       throw TFirebaseException(e.code).message;
     }
     on FormatException catch (_){
       throw TFormException();
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
      throw TFormException();
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
      throw TFormException();
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
       throw TFormException();
     }
     on PlatformException catch (e){
       throw TPlatformException(e.code).message;
     }
     catch(e){
       throw "Something went wrong, Please try again";
     }
  }



  ///-------------------FEDERATED IDENTITY & SOCIAL SIGN IN ------------------]



  ///[GoogleSignInAuthentication] ---- GOOGLE

  Future<UserCredential?> signInWithGoogle() async{
     try{

       //TRIGGER THE AUTHENTICATION FLOW
       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

       //OBTAIN THE AUTH DETAILS FROM THE REQUEST
       final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

       // create a new credential
       final credentials = GoogleAuthProvider.credential(
         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

       // ONCE SIGNED IN, RETURN THE USERCREDENTIAL
       return await _auth.signInWithCredential(credentials);
     }
     on FirebaseAuthException catch (e){
       throw TFirebaseAuthException(e.code).message;
     }
     on FirebaseException catch (e){
       throw TFirebaseException(e.code).message;
     }
     on FormatException catch (_){
       throw TFormException();
     }
     on PlatformException catch (e){
       throw TPlatformException(e.code).message;
     }
     catch(e){
       throw "Something went wrong, Please try again";
     }
  }

  ///[Logout]- VALID FOR ANY AUTHENTICATION.

  Future <void> logout() async {
     try{
       await GoogleSignIn().signOut();
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
       throw TFormException();
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
       throw TFormException();
     }
     on PlatformException catch (e){
       throw TPlatformException(e.code).message;
     }
     catch(e){
       throw "Something went wrong, Please try again";
     }
  }
}
