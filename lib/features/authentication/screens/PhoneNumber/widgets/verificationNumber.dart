import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';

import '../../../../../constants/image_string.dart';

class VerifyNumberScreen extends StatelessWidget {
  const VerifyNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const TAppBar(showBackArrow: true),
        body: Column(children: [

          /// CHEMISPHERE PNG IMAGE
          SizedBox(width:170,child: Image.asset(TImages.Chemisphere,)),

          /// VERIFICATION PAGE TITLE HARE
          const SizedBox(height:50),
          Text("Type the verification code",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center),
          // const SizedBox(height:10),
          Text("That we have sent",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center),
          const SizedBox(height:10),
          // const SizedBox(height:10),
          Text("Enter your verification code below",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),


        ]));
  }
}
