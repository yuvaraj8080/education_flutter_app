import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/image_string.dart';
import 'package:flutter_job_app/constants/sizes.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Row to position image and its corresponding text at the start
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(TImages.Chemisphere, width: 180),
          ],
        ),

        const SizedBox(height:TSizes.size4),
        Text("Chemistry made easy!", style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey.shade400)),
        const SizedBox(height: TSizes.size32),
        Text("Hey there!👋", style: Theme.of(context).textTheme.headlineMedium),
        Text("Welcome to Chemisphere",
            style: Theme.of(context).textTheme.headlineMedium),
        Text("Before continuing, please sign in first.",
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: TSizes.iconsize12),
      ],
    );
  }
}
