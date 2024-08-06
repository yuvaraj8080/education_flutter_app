import 'package:flutter/material.dart';
import '../../constants/sizes.dart';
import '../../utils/shimmer_circular_Indicator/shimmer.dart';

class TBoxShimmer extends StatelessWidget {
  const TBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: const Column(
            children:[
          TShimmerEffect(width:double.infinity, height: 70),
          SizedBox(height:TSizes.spaceBitItems16),
          TShimmerEffect(width:double.infinity, height: 70),
          SizedBox(height:TSizes.spaceBitItems16),
          TShimmerEffect(width:double.infinity, height: 70),
              SizedBox(height:TSizes.spaceBitItems16),
              TShimmerEffect(width:double.infinity, height: 70),
              SizedBox(height:TSizes.spaceBitItems16),
              TShimmerEffect(width:double.infinity, height: 70),
              SizedBox(height:TSizes.spaceBitItems16),
              TShimmerEffect(width:double.infinity, height: 70),
              SizedBox(height:TSizes.spaceBitItems16),
              TShimmerEffect(width:double.infinity, height: 70),
              SizedBox(height:TSizes.spaceBitItems16),
              TShimmerEffect(width:double.infinity, height: 70),
              SizedBox(height:TSizes.spaceBitItems16),
              TShimmerEffect(width:double.infinity, height: 70),
        ]),
      ),
    );
  }
}
