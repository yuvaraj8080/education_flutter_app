import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication-repository.dart';
import 'firebase_options.dart';

void main() async{
  ///---WIDGET BINDING
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  ///----AWAIT SPLASH UNTIL ITEM LOAD----
  FlutterNativeSplash.preserve(widgetsBinding:widgetsBinding);


  /// PREVENT ON THE SCREEN SHOT AND SCREEN RECORDING IN THIS APP
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);


  ///----INITIALIZATION FIREBASE AND AUTHENTICATION REPOSITORY----
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
        (FirebaseApp value) => Get.put(Authent,icationRepository()),
  );

  ///FLUTTER APP CHECKER
  await FirebaseAppCheck.instance.activate(
    webProvider:ReCaptchaV3Provider("recaptcha-v3-site-key"),
    androidProvider: AndroidProvider.debug,
  );

  runApp(const App());
}

