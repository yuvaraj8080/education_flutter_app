//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../common/widgets.Login_Signup/appBar/appbar.dart';
// import '../../../utils/update_name_controller.dart';
// import '../../../utils/validators/validator.dart';
//
// class ChangeName extends StatelessWidget {
//   const ChangeName({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UpdateNameController());
//     return Scaffold(
//       ///CUSTOM APPBAR
//       appBar:TAppBar(
//       showBackArrow:true,
//         title:Text("Change Name",style:Theme.of(context).textTheme.headlineSmall),
//       ),
//       body: Padding(padding:const EdgeInsets.all(8),
//       child:Column(
//         crossAxisAlignment:CrossAxisAlignment.start,
//         children:[
//           ///HEADING
//           Text("use real name for easy verification. this name will appear on several pages.",
//           style:Theme.of(context).textTheme.labelMedium,
//           ),
//           const SizedBox(height:8),
//
//           /// TEXT FIELD AND BUTTON
//           Form(
//             key:controller.updateUserNameFormKey,
//             child:Column(
//               children:[
//                 TextFormField(
//                   controller: controller.firstName,
//                   validator:(value) => TValidator.validateEmptyText("First name", value),
//                   expands: false,
//                   decoration: const InputDecoration(labelText:"First Name",prefixIcon:Icon(Iconsax.user)),
//                 ),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller:controller.lastName,
//                   validator:(value) => TValidator.validateEmptyText("Last name", value),
//                   expands: false,
//                   decoration:const InputDecoration(labelText: "Last Name",prefixIcon:Icon(Iconsax.user)),
//                 )
//               ]
//             )),
//           const SizedBox(height: 8),
//
//           /// SAVE BUTTON
//            SizedBox(
//              width:double.infinity,
//              child:ElevatedButton(onPressed:()=>  controller.updateUserName(),
//                  child:const Text("Save")),
//            )
//         ]
//       )
//       )
//     );
//   }
// }
