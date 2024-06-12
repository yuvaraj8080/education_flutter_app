import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../utils/halpers/helper_function.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;


  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunction.isDarkMode(context);
    // final isColor = THelperFunction.getColor(text) != null;
    return ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected:selected,
        onSelected:onSelected,
        labelStyle: TextStyle(color:selected ? TColors.white: null),
        // avatar:isColor ? TCircularContainer(width:50, height:50,backgroundColor:THelperFunction.getColor(text)!) : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,

      // MAKE ICON IN THE CENTER
      padding: isColor ? const EdgeInsets.all(0) : null,
          shape: isColor ? const CircleBorder(): null,
      // backgroundColor:isColor ? THelperFunction.getColor(text)!: null,
      );
  }
}
