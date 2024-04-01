import 'package:flutter/material.dart';

import '../CColors.dart';

class RoundedBorder extends StatelessWidget {
  final Widget child;
  final double innerPadding;
  final double radius;

  const RoundedBorder(
      {super.key,
      required this.child,
      required this.innerPadding,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        padding: const EdgeInsets.all(1),
        color: CColors.item,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius - 1)),
          child: Container(
              padding: EdgeInsets.all(innerPadding),
              color: CColors.background,
              child: child),
        ),
      ),
    );
  }
}
