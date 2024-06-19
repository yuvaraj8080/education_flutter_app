import 'package:flutter/material.dart';


Widget category(String subject){
  return  Card(
    elevation: 4,
    child:SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text(subject),
    
      ),
    ) ,
  );
}