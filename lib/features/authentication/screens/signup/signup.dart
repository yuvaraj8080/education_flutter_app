import 'package:flutter/material.dart';
import '../../../../common/widgets_login/form_divider.dart';
import '../../../../common/widgets_login/social_buttons.dart';
import '../../../../utils/halpers/helper_function.dart';
import 'signup_form.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar:AppBar(),
      body: SingleChildScrollView(
          child:Padding(
            padding:const EdgeInsets.all(20),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                /// Title
                Text("Lets create your account",style:Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height:24),

                /// Form TextField hare
                TSignupForm(dark: dark),
                const SizedBox(height:10),
                /// Divider
                TFormDivider(dark: dark),
                const SizedBox(height:10),
                const TSocialButtons(),
              ]
            )
          )
      ),
    );
  }
}

