import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/features/Home/controller/Url_Launcher_Controller.dart';
import 'package:flutter_job_app/utils/shimmer_circular_Indicator/shimmer.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/halpers/helper_function.dart';
import '../controller/file_controller.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fileController = Get.put(FileController());
    final urlController = Get.put(UrlController());
    final dark = THelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("Study Material", style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
        color: dark ? TColors.dark : Colors.grey.shade200,
      ),
      body: Obx(() {
        if (fileController.isLoading.value) {
          return TShimmerEffect(width:double.infinity, height:double.infinity);
        } else if (fileController.notesFiles.isEmpty) {
          return Center(child: Text('No Notes available'));
        } else {
          return ListView.builder(
            itemCount: fileController.notesFiles.length,
            padding: EdgeInsets.only(top: 20, right: 18, left: 18),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final file = fileController.notesFiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  color: dark ? TColors.dark : Colors.grey.shade200,
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf,size: 30),
                    title: Text(file.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(overflow: TextOverflow.ellipsis)),
                    subtitle: Text(file.subtitle, style: Theme.of(context).textTheme.bodySmall!.copyWith(overflow: TextOverflow.ellipsis)),
                    trailing: Icon(Iconsax.arrow_right4),
                    onTap: () => urlController.launchLink(Uri.parse(file.fileUrl)),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}