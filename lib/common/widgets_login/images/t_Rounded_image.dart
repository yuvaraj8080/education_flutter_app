import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_app/utils/shimmer_circular_Indicator/shimmer.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUlr,
    this.applyImageRadius = true,
    this.borderColor,
    this.backgroundColor,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 16,
  });

  final double? width, height;
  final String imageUlr;
  final bool applyImageRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
            fit: fit,
            imageUrl: imageUlr,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
            const TShimmerEffect(width: double.infinity, height: double.infinity),  // Adjust width and height as needed
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
              : Image(
            fit: fit,
            image: AssetImage(imageUlr) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
