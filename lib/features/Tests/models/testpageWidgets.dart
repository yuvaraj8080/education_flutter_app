import 'package:flutter/material.dart';

Widget Question(String image){
  return  Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber
                ), 
               child: Image.network(image),        
          );
}
