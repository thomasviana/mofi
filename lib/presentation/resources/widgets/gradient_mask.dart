import 'package:flutter/material.dart';

class GradientMask extends StatelessWidget {
  final Widget child;
  final Color colorA;
  final Color colorB;

  const GradientMask({
    Key? key,
    required this.child,
    required this.colorA,
    required this.colorB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [colorA, colorB],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
