import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/halpers/helper_function.dart';

class TSearchController extends StatelessWidget {
  const TSearchController({
    super.key,
    required this.text,
     this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal:16),
  });

  final String text;
  final IconData icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap:onTap,
      child: Padding(
          padding:padding,
          child:Container(width:double.infinity,padding: const EdgeInsets.all(13),
              decoration:BoxDecoration(
                  color:showBackground? dark ? TColors.dark: TColors.light:Colors.transparent,
                  borderRadius:BorderRadius.circular(16),
                  border: showBorder ? Border.all(color:TColors.grey) : null
              ),
              child:Row(children:[
                Icon(icon, color:TColors.darkGrey),
                const SizedBox(width:15),
                Text(text,style:Theme.of(context).textTheme.bodySmall),
              ])
          )
      ),
    );
  }
}
