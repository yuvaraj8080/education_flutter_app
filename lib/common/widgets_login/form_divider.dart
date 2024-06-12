import 'package:flutter/material.dart';
import '../../constants/colors.dart';


class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
                color: dark ? TColors.darkGrey : TColors.grey,
                thickness:3,
                indent: 60,
                endIndent: 5)),
        Text("Or sign in with",
            style: Theme.of(context).textTheme.labelMedium),
        Flexible(
            child: Divider(
                color: dark ? TColors.darkGrey : TColors.grey,
                thickness:3,
                indent: 5,
                endIndent: 60)),
      ],
    );
  }
}
