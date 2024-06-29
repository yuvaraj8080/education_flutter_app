import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/NetworkManager/network_manager.dart';
import '../../../data/repositories/authentication/authentication-repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/User_Model/user_model.dart';
import '../../../utils/loaders/snackbar_loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/screens/Login/login.dart';
import '../widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  get userRepository => Get.put(UserRepository());


  @override
  void onInit(){
    super.onInit();
    fetchUserRecord();
  }

  /// FETCH USER RECORD
  Future<void> fetchUserRecord() async{
    try{
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    }catch(e){
      user(UserModel.empty());
    }
    finally{
      profileLoading.value = false;
    }
  }

  /// DELETE ACCOUNT WARNING
  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(8),
      title:"Delete Account",
      middleText:"Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.",
      confirm:ElevatedButton(onPressed:() async => deleteUserAccount(),
          style:ElevatedButton.styleFrom(backgroundColor:Colors.red,side:const BorderSide(color:Colors.red)),
          child:const Padding(padding:EdgeInsets.symmetric(horizontal:8),child:Text("Delete")),
      ),
      cancel: OutlinedButton(onPressed:()=> Navigator.of(Get.overlayContext!).pop(),
          child:const Text("Cancel")
      ),
    );
  }


  /// DELETE USER ACCOUNT
  void deleteUserAccount() async{
    try{
      TFullScreenLoader.openLoadingDialog("Processing","assets/images/animations/doneEmail.webp");

      /// FIRST RE-AUTHENTICATE USER
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
       if(provider == "password"){
          TFullScreenLoader.stopLoading();
          Get.to(()=>const ReAuthLoginForm());
        }
      }
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title:"Oh Snap!",message:e.toString());
    }
  }


  ///  RE-AUTHENTICATE BEFORE DELETING
  Future<void> reAuthenticateEmailAndPasswordUser() async{
    try{
      TFullScreenLoader.openLoadingDialog("Processing","assets/images/animations/loading.json");

      /// CHECK INTERNET
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      if(!reAuthFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(),verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      TFullScreenLoader.stopLoading();
      Get.offAll(()=> const LoginScreen());
    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: "Oh Snap",message:e.toString());

    }
  }

  /// UPLOAD PROFILE IMAGE RECORD
  uploadUserProfilePicture() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
        imageQuality:70,maxHeight:70,maxWidth:512);
      if(image != null){
        imageUploading.value = true;
        // UPLOAD IMAGE
        final imageUrl = await userRepository.uploadImage("Users/Images/Profile",image);

        // UPDATE USER IMAGE RECORD
        Map<String,dynamic> json = {"ProfilePicture":imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(title:"Congratulations", message:"Your Profile Image has been updated!");
      }
    }catch(e){
      TLoaders.errorSnackBar(title:"Oh Snap",message:"Something went wrong :$e");
    }
    finally{
      imageUploading.value = false;
    }
  }
}
