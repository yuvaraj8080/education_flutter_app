import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/image_string.dart';
class PhoneNumberPage extends StatelessWidget {
  const PhoneNumberPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(left:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// CHAMISPHERE PNG IMAGE
            SizedBox(width:170,child: Image.asset(TImages.Chemisphere,)),

            /// PHONE PAGE TITLE HARE
            const SizedBox(height:50),
            Text("Login through your",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            // const SizedBox(height:10),
            Text("phone Number📱",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height:10),


            ///  ONBOARDING IMAGE HARE
            const SizedBox(height:10),
            Center(child: SvgPicture.asset("assets/images/phoneNumber.svg",width:220,height:200)),

          ],
        ),
      ),
    );
  }
}
