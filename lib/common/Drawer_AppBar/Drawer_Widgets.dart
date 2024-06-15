import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Drawer_AppBar extends StatelessWidget {
  const Drawer_AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu)),
          ),

          /// PERSON ICON HARE
          SizedBox(width: 32.w,height: 32.h,
            child: const Icon(Icons.person,color: Colors.black,
            ),
            //Image.asset("assets/images/"),
          ),
        ],
      ),
    );
  }
}
