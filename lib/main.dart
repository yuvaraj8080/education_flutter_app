import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication-repository.dart';
import 'firebase_options.dart';

void main() async{
  ///---WIDGET BINDING
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  ///----AWAIT SPLASH UNTIL ITEM LOAD----
  FlutterNativeSplash.preserve(widgetsBinding:widgetsBinding);


  ///----INITIALIZATION FIREBASE AND AUTHENTICATION REPOSITORY----
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
        (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  ///FLUTTER APP CHECKER
  await FirebaseAppCheck.instance.activate(
    webProvider:ReCaptchaV3Provider("recaptcha-v3-site-key"),
    androidProvider: AndroidProvider.debug,
  );


  runApp(const App());
<<<<<<< HEAD
  //yuvraj dekhne  

  // niraj chalke
  // niraj yuvaraj dekhane
=======
>>>>>>> 6af420604f3df7bbe26a2314da736c09fb793544
}

