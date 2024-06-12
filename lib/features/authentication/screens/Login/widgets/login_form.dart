import 'package:flutter/material.dart';
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

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "Enter E-Mail",
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              validator: (value) =>
                  TValidator.validateEmptyText("password", value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: "Enter Password",
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                TextButton(
                  onPressed: () {
                    // Navigate to ForgetPassword screen
                    Get.to(() => const ForgetPassword());
                  },
                  child: const Text("Forget Password"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Perform email and password sign in
                  controller.emailAndPasswordSignIn();
                },
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to SignupScreen
                  Get.to(const SignupScreen());
                },
                child: const Text("Create New Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
