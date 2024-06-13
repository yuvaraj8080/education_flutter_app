
  import 'package:flutter/cupertino.dart';
import 'package:flutter_job_app/constants/image_string.dart';
  import 'package:get/get.dart';
  import 'package:get_storage/get_storage.dart';
  import '../../../../common/NetworkManager/network_manager.dart';
import '../../../../data/repositories/authentication/authentication-repository.dart';
import '../../../../utils/loaders/snackbar_loader.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';

  class LoginController extends GetxController{

    /// VARIABLES
    final rememberMe  = false.obs;
    final hidePassword  = true.obs;
    final localStorage = GetStorage();
    final email = TextEditingController();
    final password = TextEditingController();
    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    final userController = Get.put(UserController());


    @override
    void onInit(){
      email.text = localStorage.read("REMEMBER_ME_EMAIL")??'';
      password.text = localStorage.read("REMEMBER_ME_PASSWORD")??'';
      super.onInit();
    }

    ///EMAIL AND PASSWORD SIGN IN
    Future<void> emailAndPasswordSignIn () async{
      try{
        //  START LOADING
        TFullScreenLoader.openLoadingDialog("Wait for login",TImages.loadingAnimation);

        // CHECK INTERNET CONNECTIVITY
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }

        //PRIVACY POLICY CHECk
        if (!rememberMe.value) {
          TLoaders.warningSnackBar(title: "Accept Privacy Policy",
              message: "In order to create account, you must have to read and accept the Privacy Policy & term of use");
          TFullScreenLoader.stopLoading();
          return;
        }


        //  FORM VALIDATION
        if(!loginFormKey.currentState!.validate()){
          TFullScreenLoader.stopLoading();
        }


        //SAVE DATE IF REMEMBER ME IS SELECTED

        if(rememberMe.value){
          localStorage.write("REMEMBER_ME_EMAIL",email.text.trim());
          localStorage.write("REMEMBER_ME_PASSWORD",password.text.trim());
        }

        // LOGIN USER EMAIL & PASSWORD AUTHENTICATION
        final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(),password.text.trim());


        //REMOVE LOADER

        TFullScreenLoader.stopLoading();

        // REDIRECT
        AuthenticationRepository.instance.screenRedirect();
      }catch(e){

        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());

      }
    }



  }