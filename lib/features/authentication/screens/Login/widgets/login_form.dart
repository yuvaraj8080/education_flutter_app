import 'package:flutter/material.dart';
import 'package:flutter_job_app/constants/colors.dart';
import 'package:flutter_job_app/constants/sizes.dart';
import 'package:flutter_job_app/features/authentication/screens/PhoneNumber/phoneNumber_Screen.dart';
import 'package:flutter_job_app/utils/halpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/validators/validator.dart';
import '../../password_configuration/forget_password.dart';
import '../../../controllers/login/login_controller.dart';
import '../../signup/signup.dart';


class TLoginForm extends StatelessWidget {
  const TLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = THelperFunction.isDarkMode(context);

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "Enter your E-Mail ID",labelStyle:TextStyle(color:Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              validator: (value) =>
                  TValidator.validateEmptyText("password", value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: "Enter Password",labelStyle:const TextStyle(color:Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            )),
            const SizedBox(height:TSizes.size16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// LOGIN WITH PHONE NUMBER
                TextButton(
                  onPressed: () {
                    Get.to(()=> const PhoneNumberScreen());
                  },
                  child:Text("Login via OTP",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight:FontWeight.bold))),

                /// FORGET PASSWORD TO CREATE NEW PASSWORD
                TextButton(
                  onPressed: () {
                    // Navigate to ForgetPassword screen
                    Get.to(() => const ForgetPassword());
                  },
                  child:Text("Forget Password?",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight:FontWeight.bold)),
                ),
              ],
            ),

            /// TERM AND PRIVACY AND POLICY
            Row(
              children: [
                Obx(() => Checkbox(
                  value: controller.rememberMe.value,
                  onChanged: (value) =>
                  controller.rememberMe.value = !controller.rememberMe.value,
                )),
                const Text("Remember Me"),
              ],
            ),

            /// SIGN IN BUTTON
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style:ButtonStyle(backgroundColor:WidgetStateProperty.all<Color>(TColors.darkGrey) ),
                onPressed: () {
                  // Perform email and password sign in
                  controller.emailAndPasswordSignIn();
                },
                child: const Text("Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
