

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    final controller = Get.put(BannerController()); // Initialize your controller properly
    return Obx((){
      /// LOADER
      if(controller.isLoading.value) return const TShimmerEffect(width: double.infinity, height:190);

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
                imageUlr: banner.imageUrl,
                isNetworkImage:true,
                onPressed:()=> Get.toNamed(banner.targetScreen),
              ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) => controller.updatePageIndicator(index),
              ),
            ),
            const SizedBox(height: 16),
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
