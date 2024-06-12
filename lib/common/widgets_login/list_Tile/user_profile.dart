import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../constants/colors.dart';
import '../../../features/personalization/controllers/user_controller.dart';
import '../images/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
   TUserProfileTile({
    super.key, required this.onPressed,
  });

   final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const TCircularImage(image: "assets/user/UserImge.png"),
      title: Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
      subtitle: Text(controller.user.value.email,style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton(onPressed:onPressed, icon: const Icon(Iconsax.edit, color: Colors.white)),
    );
  }
}
