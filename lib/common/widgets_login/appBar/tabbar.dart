import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../utils/halpers/helper_function.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget{
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable:true,
        indicatorColor:TColors.primaryColor,
        unselectedLabelColor:TColors.darkGrey,
        labelColor:dark ? TColors.white : TColors.primaryColor,
      )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>const Size.fromHeight(kToolbarHeight);
}
