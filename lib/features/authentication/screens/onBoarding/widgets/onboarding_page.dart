import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/image_string.dart';

class onBordingPage extends StatelessWidget {
  const onBordingPage({
    super.key, required this.image, required this.title, required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// CHAMISPHERE PNG IMAGE
          const SizedBox(height:100),
         SizedBox(width:160,child: Image.asset(TImages.Chemisphere,)),

          ///  ONBOARDING IMAGE HARE
          Center(
            child: Image(
              width: MediaQuery.of(context).size.width * .6,
              height: MediaQuery.of(context).size.height * .4,
              image: AssetImage(image),
            ),
          ),

          /// ONBOARDING TITLE HARE

          Center(
            child: Text(title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
          ),
          const SizedBox(height:10),

          /// ONBOARDING SUBTITLE HARE
          Center(
            child: Text(subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}