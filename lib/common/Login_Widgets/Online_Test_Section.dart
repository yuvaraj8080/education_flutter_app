import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TCommonCard.dart';


class TOnlineTestSection extends StatelessWidget {
  const TOnlineTestSection({
    super.key, required this.firstName, required this.lastName, required this.secondTap,
  });

  final String firstName, lastName;
  final VoidCallback secondTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        CommonCard(firstName,context),

        GestureDetector(
          onTap:secondTap,child: CommonCard(lastName,context)
        ),
      ],
    );
  }
}