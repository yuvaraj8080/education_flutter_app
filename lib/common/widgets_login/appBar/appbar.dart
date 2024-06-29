import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
class TAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TAppBar({super.key, this.title,  this.showBackArrow = false, this.leadingIcon, this.actions, this.leadingPressed, this.color});

  final Widget? title;
  final Color? color;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingPressed;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading:false,
      leading: showBackArrow
        ? IconButton(onPressed: () => Get.back(), icon:const Icon(Iconsax.arrow_left))
          : leadingIcon != null ? IconButton(onPressed:leadingPressed, icon:Icon(leadingIcon)): null,
      title:title,
      actions: actions,
      backgroundColor:color,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
