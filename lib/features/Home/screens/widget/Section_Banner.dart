import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Home/controller/Url_Launcher_Controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets_login/images/circular_container.dart';
import '../../../../common/widgets_login/images/t_Rounded_image.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/shimmer_circular_Indicator/shimmer.dart';
import '../../controller/Banner_Controller.dart';

class TSectionBanners extends StatelessWidget {
  const TSectionBanners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    final urlController = Get.put(UrlController());
    return Obx((){
      /// LOADER
      if(controller.isLoading.value) return const TShimmerEffect(width: double.infinity, height:150);

      if(controller.banners.isEmpty){
        return const TShimmerEffect(width: double.infinity, height: double.infinity);
        // return const Center(child: Text("No Data Found"));
      }
      else{
        return Column(
          children: [
            CarouselSlider(
              items: controller.banners
                  .map((banner) => TRoundedImage(
                width:250,
                applyImageRadius: true,
                fit:BoxFit.contain,
                padding:EdgeInsets.only(left:10.w),
                imageUlr: banner.imageUrl,
                isNetworkImage:true,
                onPressed:()=>urlController.launchLink(Uri.parse(banner.targetScreen)),
              ))
                  .toList(),
              options: CarouselOptions(
                autoPlay:true,
                viewportFraction:0.8,
                onPageChanged: (index, _) => controller.updatePageIndicator(index),
              ),
            ),
            // const SizedBox(height: 16),
            Center(
              child: Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    TCircularContainer(
                      width: 20,
                      height: 5,
                      margin: const EdgeInsets.only(right: 8),
                      backgroundColor:
                      controller.carousalCurrentIndex.value == i
                          ? TColors.primaryColor
                          : TColors.grey,
                    )
                ],
              )),
            )
          ],
        );
      }
    });
  }
}
