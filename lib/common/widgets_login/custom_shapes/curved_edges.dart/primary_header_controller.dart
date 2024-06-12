import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../container/circular_container.dart';
import 'curved_edges.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: TColors.primaryColor,
        child: Stack(
          children: [
            /// Creating the Stack Position
            Positioned(top: -220, right: -80, child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(top: 50,right: -250,child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child
            // Add your other widgets or content here
          ],
        ),
      ),
    );
  }
}

class TCurvedEdgesWidget extends StatelessWidget {
  const TCurvedEdgesWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvesEdge(),
      child: child,
    );
  }
}
