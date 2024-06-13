import 'package:flutter/material.dart';
import 'package:flutter_job_app/common/widgets_login/appBar/appbar.dart';
import 'package:flutter_job_app/data/repositories/authentication/authentication-repository.dart';
import 'package:get/get.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return  Scaffold(
      appBar:TAppBar(title:const Text("Chemisphere"),actions: [
        IconButton(onPressed:controller.logout, icon:const Icon(Icons.logout))
      ],),
    );
  }
}
