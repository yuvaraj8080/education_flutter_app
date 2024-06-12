import 'package:flutter/material.dart';

import 'custom_shapes/curved_edges.dart/curved_edges.dart';

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
