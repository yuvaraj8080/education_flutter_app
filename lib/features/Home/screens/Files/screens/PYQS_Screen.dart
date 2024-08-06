import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/shimmers/box_shimmer.dart';
import 'package:flutter_job_app/features/Home/screens/Files/controller/file_controller.dart';
import 'package:flutter_job_app/utils/shimmer_circular_Indicator/shimmer.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets_login/appBar/appbar.dart';
import '../../../../../constants/colors.dart';
import '../../../../../utils/halpers/helper_function.dart';
import '../../../controller/Url_Launcher_Controller.dart';

class PYQScreen extends StatelessWidget {
  const PYQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pyqController = Get.put(FileController());
    final urlController = Get.put(UrlController());
    final dark = THelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text("PYQs", style: Theme.of(context).textTheme.titleLarge),
        showBackArrow: true,
        color: dark? TColors.dark : Colors.grey.shade200,
      ),
      body: Obx(() {
        if (pyqController.isLoading.value) {
          return TBoxShimmer();
        } else if (pyqController.pyqsFiles.isEmpty) {
          return Center(child: Text('No PYQs Available'));
        } else {
          return ListView.builder(
            itemCount: pyqController.pyqsFiles.length,
            padding: EdgeInsets.only(top: 20, right: 18, left: 18),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final pyq = pyqController.pyqsFiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  color: dark? TColors.dark : Colors.grey.shade200,
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf,size: 30),
                    title: Text(pyq.title, style: Theme.of(context).textTheme.titleSmall!.copyWith(overflow: TextOverflow.ellipsis)),
                    subtitle: Text(pyq.subtitle, style: Theme.of(context).textTheme.labelMedium!.copyWith(overflow: TextOverflow.ellipsis)),
                    trailing: Icon(Iconsax.arrow_right),
                    onTap: () => urlController.launchLink(Uri.parse(pyq.fileUrl)),
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