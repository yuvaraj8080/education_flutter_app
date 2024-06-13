import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/authentication/screens/PhoneNumber/widgets/phoneNumber_page.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/validators/validator.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        PhoneNumberPage(),

        /// PHONE NUMBER TEXT FROM FIELD
          SizedBox(
            child: TextFormField(
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: "Enter your phone number",labelStyle:TextStyle(color:Colors.grey),
            ),
            ),
          ),
      ],),
    );
  }
}
