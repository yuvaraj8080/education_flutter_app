import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/NetworkManager/network_manager.dart';
import '../../../../data/repositories/authentication/authentication-repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/User_Model/user_model.dart';
import '../../../../utils/loaders/snackbar_loader.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  ///-----VARIABLES------
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final location = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey();

  /// -----SIGNUP------
   void signup() async {
     try {
       //START LOADING
       TFullScreenLoader.openLoadingDialog(
           "We are processing your information...","assets/images/animations/loading.json");

       ///CHECK INTERNET CONNECTIVITY
       final isConnected = await NetworkManager.instance.isConnected();
       if (!isConnected){
         TFullScreenLoader.stopLoading();
         return;
       }


       // FORM VALIDATION
       if (!signupFormKey.currentState!.validate()){
         TFullScreenLoader.stopLoading();
         return;
       }

       //PRIVACY POLICY CHECk
       if (!privacyPolicy.value) {
         TLoaders.warningSnackBar(title: "Accept Privacy Policy",
             message: "In order to create account, you must have to read and accept the Privacy Policy & term of use"
         );
         return;
       }

       //----REGISTER USER IN THE FIREBASE AUTHENTICATION & SAVE USER DATA IN THE FIREBASE
       final userCredential = await AuthenticationRepository.instance
           .registerWithEmailAndPassword(email.text.trim(), password.text.trim());


       //SAVE AUTHENTICATION USER DATA INT THE FIREBASE FIRESTORE
       final newUser = UserModel(
         id: userCredential.user!.uid,
         firstName: firstName.text.trim(),
         lastName: lastName.text.trim(),
         username: username.text.trim(),
         email: email.text.trim(),
         location: location.text.trim(),
         profilePicture: '',
       );

       final userRepository = Get.put(UserRepository());
       await userRepository.saveUserRecord(newUser);


       //REMOVE LOADER
       TFullScreenLoader.stopLoading();


       ///SHOW  SUCCESS MESSAGE
       TLoaders.successSnackBar(
           title: "Congratulation",
           message: "Your Account has been Created! Verify email to Continue.");

       // MOVE TO VERIFY EMAIL SCREEN
       Get.to(() => VerifyEmailScreen(email:email.text.trim()));

     }
    catch(e){
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
  // SHOW SOME GENERIC ERROR TO USER
      TLoaders.errorSnackBar(title:"Oh Snap!",message:"Something went wrong! Check your Network connection");
    }
  }
}