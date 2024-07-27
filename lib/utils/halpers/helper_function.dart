import 'package:flutter/material.dart';

class THelperFunction{

  THelperFunction._();



  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

}