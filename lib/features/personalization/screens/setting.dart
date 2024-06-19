import 'package:flutter/material.dart';
import 'package:flutter_job_app/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets_login/appBar/appbar.dart';
import '../../../common/widgets_login/list_Tile/setting_menu_tile.dart';
import '../../../common/widgets_login/list_Tile/user_profile.dart';
import '../../../constants/colors.dart';
import '../../../constants/section_heading.dart';
import '../../../data/repositories/authentication/authentication-repository.dart';
import 'profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      ///-------HEADER-------
      Column(children: [TAppBar(
            title: Text("Account",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.white))),

        ///------USER PROFILE CARD-------
        TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
        const SizedBox(height: 20)
      ]),

      ///-------PROFILE BODY ---------
      Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const TSectionHeading(
                title: "Account Setting", showActionButton: false),
            const SizedBox(height: 8),
            TSettingMenuTile(
                icon: Iconsax.safe_home,
                title: "My Address",
                subTitle: "Set shopping delivery address",
                onTap: () {}),
            TSettingMenuTile(
                icon: Iconsax.shopping_cart,
                title: "My Cart",
                subTitle: "Add, remove products and move to checkout",
                onTap: () {}),
            TSettingMenuTile(
                icon: Iconsax.bag_tick,
                title: "My Orders",
                subTitle: "In-progress and Completed Orders",
                onTap: () {}),
            TSettingMenuTile(
                icon: Iconsax.bank,
                title: "My Account",
                subTitle: "Withdraw balance to registered bank account",
                onTap: () {}),
            TSettingMenuTile(
                icon: Iconsax.discount_shape,
                title: "My Coupons",
                subTitle: "List of all the discount coupons",
                onTap: () {}),
            TSettingMenuTile(
                icon: Iconsax.notification,
                title: "Notification",
                subTitle: "Set any kind of notification messages",
                onTap: () {}),
            TSettingMenuTile(
                icon: Iconsax.security_card,
                title: "Account Privacy",
                subTitle: "Manage data usage and connected accounts",
                onTap: () {}),

            ///--------APP SETTING-------
            const SizedBox(height: 8),
            const TSectionHeading(
                title: "App Setting", showActionButton: false),
            const SizedBox(height: 8),
            const TSettingMenuTile(
                icon: Iconsax.document,
                title: "load Data",
                subTitle: "Upload Data to your Cloud Firebase"),
            TSettingMenuTile(
              icon: Iconsax.location,
              title: "Geolocation",
              subTitle: "Set recommendation based on location",
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            TSettingMenuTile(
              icon: Iconsax.security_user,
              title: "Safe Mode",
              subTitle: "Search result is safe for all ages",
              trailing: Switch(value: false, onChanged: (value) {}),
            ),
            TSettingMenuTile(
              icon: Iconsax.image,
              title: "HD Image Quality",
              subTitle: "Set Image quality to be seen",
              trailing: Switch(value: false, onChanged: (value) {}),
            ),

            ///--------LOGOUT BUTTON---------
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: const Text("Logout")),
            ),
          ]))
    ])));
  }
}
