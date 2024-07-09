import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TCommonCard.dart';


class TOnlineTestSection extends StatelessWidget {
  const TOnlineTestSection({
    super.key, required this.firstName, required this.lastName, required this.secondTap, required this.firstTap,
  });

  final String firstName, lastName;
  final VoidCallback secondTap;
  final VoidCallback firstTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        GestureDetector(
          onTap:firstTap,
            child: CommonCard(firstName,context)),

        GestureDetector(
          onTap:secondTap,child: CommonCard(lastName,context)
        ),
      ],
    );
  }
}