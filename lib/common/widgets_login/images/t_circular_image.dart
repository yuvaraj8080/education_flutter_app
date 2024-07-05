import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../utils/halpers/helper_function.dart';
import '../../../utils/shimmer_circular_Indicator/shimmer.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 60,
    this.height = 60,
    this.padding = 16,
    this.borderColor,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (THelperFunction.isDarkMode(context) ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: borderColor ?? Colors.transparent, // Set border color or transparent if null
          width: 2.0, // Set the border width
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
            fit: fit,
            color: overlayColor,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
            const TShimmerEffect(width: 55, height: 55, radius: 55),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
              : Image(
            fit: fit,
            color: overlayColor,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
