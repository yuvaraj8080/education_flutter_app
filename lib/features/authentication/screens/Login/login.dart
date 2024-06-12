import 'package:flutter/material.dart';
import '../../../../common/widgets_login/form_divider.dart';
import '../../../../common/widgets_login/social_buttons.dart';
import '../../../../utils/halpers/helper_function.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);



    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 56, left: 20, right: 20, bottom: 20),
        child: Column(children: [
          ///  Logo title And Subtitle,
          TLoginHeader(dark: dark),

          /// Form TextField
          const TLoginForm(),

          ///    Divider
          TFormDivider(dark: dark),

          const SizedBox(height: 16,),
          ///  Footer Social Buttons
          const TSocialButtons()
        ]),
      ),
    ));
  }
}




