import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets_login/appBar/appbar.dart';
import '../../../common/widgets_login/images/t_circular_image.dart';
import '../../../constants/section_heading.dart';
import '../../../utils/shimmer_circular_Indicator/shimmer.dart';
import '../controllers/user_controller.dart';
import '../widgets/profile_menu.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar:const TAppBar(showBackArrow:false,title:Text("Profile")),

      ///------BODY-------
      body:SingleChildScrollView(
        child:Padding(padding:const EdgeInsets.all(20),
        child:Column(
          children:[

            ///-----PROFILE PICTURE--------k
            SizedBox(
              width:double.infinity,
              child:Column(
                  children:[
                    Obx(() {
                      final user = controller.user.value.profilePicture;
                      final image = user.isNotEmpty? user :"assets/images/user.png";
                      return controller.imageUploading.value
                      ? const TShimmerEffect(width:80, height: 80)
                      :TCircularImage(image:image,width:100,height:100,isNetworkImage:user.isNotEmpty ? true : false);

                    }),
                OutlinedButton(onPressed:() => controller.uploadUserProfilePicture(), child: Text("Change Profile Picture",style:Theme.of(context).textTheme.titleSmall))
              ])
            ),

            ///------DETAIL--------
            const Divider(),
            const SizedBox(height:5),
            const TSectionHeading(title:"Profile Inforamation",showActionButton:false),
            const SizedBox(height:8),

            TProfileMenu(title:"Name",value:controller.user.value.fullName,onPressed:(){}),
            TProfileMenu(title:"StudentID",value:controller.user.value.studentId,onPressed:(){}),

             ///-----HEADING PERSONAL INFORMATION-------

            const TSectionHeading(title:"Personal Information",showActionButton:false),
            const SizedBox(height:8),

            TProfileMenu(title:"Batch", value:controller.user.value.batch,icon:Iconsax.copy,onPressed:(){}),
            TProfileMenu(title:"E-Mail", value:controller.user.value.email,onPressed:(){}),
            TProfileMenu(title:"Mobile", value:controller.user.value.phoneNumber,onPressed:(){}),
            const Divider(),
            const SizedBox(height:10),
            Center(child: TextButton(
              onPressed:() => controller.deleteAccountWarningPopup(),child:Text("Logout",style:Theme.of(context).textTheme.titleMedium!.copyWith(color:TColors.primaryColor)),
            ))
          ]
        )
        )
      )
    );
  }
}

