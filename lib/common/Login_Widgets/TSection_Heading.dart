import 'package:flutter/material.dart';

Widget TSectionHeading(BuildContext context, String title, {double? size,Color? textColor}) {
  return Text(
    title,
    style: Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontSize: size, fontFamily: "CircularStd",color:textColor  ),
  );
}
