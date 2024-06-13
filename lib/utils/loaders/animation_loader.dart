import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';



class TAnimationLoaderWidget  extends StatelessWidget {
  const TAnimationLoaderWidget ({
    super.key,
    required this.text,
    required this.animation,
     this.showAction = false,
     this.actionText,
    this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback ? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:MainAxisAlignment.center,
        children:[
          const SizedBox(height:200),
          Lottie.asset(animation,width:MediaQuery.of(context).size.width*0.8),
          const SizedBox(height:8),
          Text(text,style:Theme.of(context).textTheme.bodyMedium,
            textAlign:TextAlign.center),
          const SizedBox(height:8),
          showAction ? SizedBox(
            width: 250,
              child: OutlinedButton(onPressed:onActionPressed,
            style:OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                  child:Text(
                    actionText!,
                    style:Theme.of(context).textTheme.bodyMedium!.apply(color:TColors.light)
                  ))
          )
              :const SizedBox(),
        ]
      )
    );
  }
}
