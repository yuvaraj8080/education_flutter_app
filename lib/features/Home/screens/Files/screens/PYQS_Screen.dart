import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/halpers/helper_function.dart';
import '../../../controller/Url_Launcher_Controller.dart';



class PYQScreen extends StatelessWidget {
  const PYQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final urlController = Get.put(UrlController());
    final dark = THelperFunction.isDarkMode(context);
    return  Scaffold(
      appBar:TAppBar(title:Text("PYQS Material",style:Theme.of(context).textTheme.headlineSmall),
        showBackArrow:true,
        color:dark ?TColors.dark : Colors.grey.shade200),
      body: ListView.builder(
      itemCount:10,padding:EdgeInsets.only(top:20,right:18,left:18),
      shrinkWrap:true,
      itemBuilder: (context, index) {
        // final note = notes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom:10),
          child: Card(
            color:dark ?TColors.dark : Colors.grey.shade200,
            child: ListTile(
              // leading: Icon(note['leading'] as IconData),
              title: Text("Chemistry May-2023",style:Theme.of(context).textTheme.titleLarge!.copyWith(overflow:TextOverflow.ellipsis)),
              subtitle: Text("Aldehyde_ketone.pdf",style:Theme.of(context).textTheme.bodySmall!.copyWith(overflow:TextOverflow.ellipsis)),
              trailing:Icon(Iconsax.document_download),
              onTap: ()=>urlController.launchLink(Uri.parse("https://drive.google.com/file/d/1yZfv_SM6c7NIQe7GxLw2hskZ9Ou_eS9T/view?usp=drive_link")),
            ),),
           );
        },
      )
    );
  }
}
