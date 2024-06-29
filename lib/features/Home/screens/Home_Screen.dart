  import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/common/widgets_login/images/t_Rounded_image.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/constants/sizes.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter_job_app/features/personalization/screens/profile.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/Login_Widgets/Online_Test_Section.dart';
import '../../../common/Login_Widgets/TOnlineLectureSection.dart';
import '../../../common/Login_Widgets/TSection_Heading.dart';
import 'widget/Section_Banner.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final user = controller.user.value;
    return Scaffold(
      /// ==== APP BAR HARE===
      appBar:TAppBar(showBackArrow: false,color:THelperFunction.isDarkMode(context)
          ?TColors.dark : Colors.grey.shade200,
        title:Image.asset("assets/images/ChemisphereFlash.png",width:130,height:30),
        actions:[
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: Row(children:[
              IconButton(onPressed:(){}, icon:Icon(Iconsax.notification,size:30,)),
              SizedBox(width:TSizes.size8),
              TRoundedImage(
                onPressed:()=> Get.to(()=> ProfileScreen()),
                isNetworkImage:user.profilePicture.isNotEmpty ? true : false,fit:BoxFit.cover,height:30,width:30,
                imageUlr: user.profilePicture.isNotEmpty ? user.profilePicture : 'assets/images/user.png',
              )
            ]),
          )
        ],
      ),

        body: Padding(
          padding: const EdgeInsets.only(left:20,right:20),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [

              /// SECTION HEADING
              //[================== if(user.batch == Batch.JEE12) ==================]
                TSectionHeading(context,"Whats new? 👀"),

              /// HOME SCREEN BANNER
              TSectionBanners(),

              /// HOME SCREEN HEADING
              Padding(
                padding: const EdgeInsets.only(left:10,top: 20),
                child: TSectionHeading(context,"What are you looking for?",size:18),
              ),

              /// ONLINE LACTURE SECTION
              TOnlineLectureSection(context),

              /// PAST TEST AND NOTES HARE
              SizedBox(height: 10.h),
              TOnlineTestSection(firstName: 'Past tests', lastName: 'Notes'),

              /// PYQ AND MY SCORES HARE
              TOnlineTestSection(firstName: 'PYQS', lastName: 'My Scores'),

            ],
          ),
        ));
  }
}



