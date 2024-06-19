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

  Widget ElevatedButton(String text){
return
   Container(
   height:50,
   width: 100,
   decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Color(0xff09203f),
   boxShadow:[
    BoxShadow(
      color: Colors.white,
      offset: Offset(4, 4) ,
      blurRadius: 12,
      spreadRadius: 1,
    ),
      BoxShadow(
      color: Colors.grey.shade600,
      offset: Offset(-4, -4) ,
      blurRadius: 12,
      spreadRadius: 1,
    ),


   ]
   

   ),
   child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),

   

   );
     
  }


}