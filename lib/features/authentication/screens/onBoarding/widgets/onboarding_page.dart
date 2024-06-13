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
         Padding(
           padding: const EdgeInsets.only(top:100,left:10),
           child: SizedBox(width:170,child: Image.asset(TImages.Chemisphere,)),
         ),

          ///  ONBOARDING IMAGE HARE
          Center(
            child: Image(
              width: MediaQuery.of(context).size.width * .7,
              height: MediaQuery.of(context).size.height * .5,
              image: AssetImage(image),
            ),
          ),

          /// ONBOARDING TITLE HARE

          Center(
            child: Text(title,
                style: Theme.of(context).textTheme.headlineSmall,
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