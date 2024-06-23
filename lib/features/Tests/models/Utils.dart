import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {


  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  Widget ElevatedButton(String text,Color buttonColor){
  return
   Container(
   height:50,
   width: 200,
   decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: buttonColor,
   

   ),
   child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),

   

   );
     
  }


}