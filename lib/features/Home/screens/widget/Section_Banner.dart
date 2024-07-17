import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/Home/controller/Url_Launcher_Controller.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
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
      }
      else{
        return Column(
          children: [
            CarouselSlider(
              items: controller.banners
                  .map((banner) => Stack(
                    children: [
                      TRoundedImage(
                                      applyImageRadius: true,
                                      fit:BoxFit.contain,
                                      padding:EdgeInsets.only(left:10.w),
                                      imageUlr: banner.imageUrl,
                                      isNetworkImage:true,
                                      onPressed:()=>urlController.launchLink(Uri.parse(banner.targetScreen)),
                                    ),
                      Positioned(
                        left:14,bottom:22,
                          child:Container(
                            decoration:BoxDecoration(
                                color: THelperFunction.isDarkMode(context)? TColors.dark.withOpacity(0.9) : Colors.grey.withOpacity(0.9),
                                borderRadius:BorderRadius.vertical(bottom:Radius.circular(10))
                            ),child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(banner.title,style:Theme.of(context).textTheme.titleSmall),
                              )))
                      ],
                  ),
              )
                  .toList(),
              options: CarouselOptions(height:160,
                autoPlay:true,
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
