//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../common/NetworkManager/network_manager.dart';
// import '../data/repositories/user/user_repository.dart';
// import '../features/personalization/controllers/user_controller.dart';
// import '../features/personalization/screens/profile.dart';
// import 'loaders/snackbar_loader.dart';
// import 'popups/full_screen_loader.dart';
//
// ///  CONTROLLER TO MANAGE USER-RELATED FUNCTIONALITY
// class UpdateNameController extends GetxController{
//   static UpdateNameController get instance => Get.find();
//
//
//   final firstName = TextEditingController();
//   final lastName = TextEditingController();
//   final userController = UserController.instance;
//   final userRepository = Get.put(UserRepository());
//   GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
//
//   ///  INIT USER DATA WHEN HOME SCREEN APPEARS
//   @override
//   void onInit(){
//     initializeNames();
//     super.onInit();
//   }
//
//
//   /// FETCH USER RECORD
//   Future<void> initializeNames() async {
//     firstName.text = userController.user.value.firstName;
//     lastName.text = userController.user.value.lastName;
//   }
//
//   Future<void> updateUserName() async{
//     try{
//     /// START LOADING
//        TFullScreenLoader.openLoadingDialog("We are updating your information...","assets/images/animations/loading.json");
//
//     /// CHECK INTERNET CONNECTIVITY
//         final isConnected = await NetworkManager.instance.isConnected();
//         if(!isConnected){
//           TFullScreenLoader.stopLoading();
//           return;
//         }
//
//         /// FORM VALIDATION
//         if(!updateUserNameFormKey.currentState!.validate()){
//           TFullScreenLoader.stopLoading();
//           return;
//         }
//
//         /// UPDATE  USER'S FIRST & LAST NAME IN THE FIREBASE FIRESTORE
//       Map<String,dynamic> name = {"FirstName":firstName.text.trim(),"LastName":lastName.text.trim()};
//         await userRepository.updateSingleField(name);
//
//
//         /// UPDATE THE RX USER VALUE
//        userController.user.value.firstName = firstName.text.trim();
//        userController.user.value.lastName = lastName.text.trim();
//
//
//        ///  REMOVE LOADER
//        TFullScreenLoader.stopLoading();
//
//        /// SHOW SUCCESS MESSAGE
//       TLoaders.successSnackBar(title:"Congratulations",message:"Your Name has been updated.");
//
//       /// MOVE TO PREVIOUS SCREEN
//       Get.off(()=> const ProfileScreen());
//     }
//     catch(e){
//       TFullScreenLoader.stopLoading();
//       TLoaders.errorSnackBar(title:"Oh snap",message:e.toString());
//     }
//   }
//
// }
