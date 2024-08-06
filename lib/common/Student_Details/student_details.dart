import 'package:flutter/material.dart';

class TStudentDetails extends StatelessWidget {
  TStudentDetails({
    super.key,required this.name,
  });

  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(name,style:Theme.of(context).textTheme.titleMedium,overflow:TextOverflow.ellipsis),
    );
  }
}