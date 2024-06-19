import 'package:flutter/cupertino.dart';
import 'TCommonCard.dart';


class TOnlineTestSection extends StatelessWidget {
  const TOnlineTestSection({
    super.key, required this.firstName, required this.lastName,
  });

  final String firstName, lastName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CommonCard(firstName,context),
        CommonCard(lastName,context),
      ],
    );
  }
}