import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';


class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.width =400,
    this.height = 400,
    this.radius = 400,
    this.backgroundColor = TColors.white,
    this.padding = 0,
    this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin:margin,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),child:child,
    );
  }
}
