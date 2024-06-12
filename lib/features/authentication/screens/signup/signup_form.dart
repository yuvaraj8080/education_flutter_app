import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/validators/validator.dart';
import '../../controllers/signup/sugnup_controller.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
        child:Column(
        children:[
          Row(
              children:[
            ///  First Name TextField
            Expanded(
                child: TextFormField(expands: false,controller:controller.firstName,
                    decoration:const InputDecoration(labelText:"First Name",prefixIcon:Icon(Iconsax.user)),
                  validator:(value) => TValidator.validateEmptyText("First Name",value),
                )),
            const SizedBox(width:16),

            /// Last Name TextField
            Expanded(
                child: TextFormField(expands: false,controller:controller.lastName,
                    decoration:const InputDecoration(labelText:"Last Name",prefixIcon:Icon(Iconsax.user)),
                  validator:(value) => TValidator.validateEmptyText("Last Name",value),

                )),
          ]),
          const SizedBox(height:15),

          ///    Username TextField
          TextFormField(expands:false,controller:controller.username,
              decoration: const InputDecoration(labelText:"Username",prefixIcon:Icon(Iconsax.user_edit)),
            validator:(value) => TValidator.validateEmptyText("username",value),

          ),
          const SizedBox(height:15),

          ///  E_Mail TextField
          TextFormField(expands:false,controller: controller.email,
              decoration: const InputDecoration(labelText:"E-Mail",prefixIcon:Icon(Iconsax.direct)),
            validator:(value) => TValidator.validateEmail(value),

          ),
          const SizedBox(height:15),

          ///  Phone Number TextField
          TextFormField(expands:false,controller:controller.location,
              decoration: const InputDecoration(labelText:"Location",prefixIcon:Icon(Iconsax.location)),
            validator:(value) => TValidator.stringValue(value),

          ),
          const SizedBox(height:15),

          ///  password  TextField
          Obx( ()=> TextFormField(expands:false,
            controller:controller.password,
                obscureText:controller.hidePassword.value,
                decoration:  InputDecoration(
                    labelText:"Password",
                    prefixIcon:Icon(Iconsax.password_check),
                    suffixIcon:IconButton(
                        onPressed:() => controller.hidePassword.value = !controller.hidePassword.value,
                        icon:Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))
                ),
              validator:(value) => TValidator.validatePassword(value),

            ),
          ),


          ///  Term Condition Checkbox
          const SizedBox(height:10),
          Row(children:[
            SizedBox(height:24,width:24,child:Obx(() => Checkbox(value:controller.privacyPolicy.value,
                onChanged: (value)=>controller.privacyPolicy.value = !controller.privacyPolicy.value))),
            Text(" I agree to",style:Theme.of(context).textTheme.bodySmall),
            Text(" Privacy Policy",style:Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark? TColors.primaryColor :Colors.blueAccent)),
            Text(" and",style:Theme.of(context).textTheme.bodySmall),
            Text(" Term of use",style:Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark? TColors.primaryColor :Colors.blueAccent)),
          ]),
          const SizedBox(height:15),

          /// Sign Up Button Create Account button
          SizedBox(width:double.infinity,
              child:ElevatedButton(
              onPressed:() => controller.signup(),
              child:const Text("Create Account")))
        ]
    ));
  }
}
