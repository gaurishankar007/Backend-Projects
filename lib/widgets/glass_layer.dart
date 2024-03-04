import 'dart:ui';
import 'package:chat/injection/injector.dart';
import 'package:flutter/material.dart';

class GlassLayer extends StatelessWidget {
  final double? opacity;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final double blur;
  final Widget child;

  const GlassLayer({
    super.key,
    this.borderRadius,
    this.border,
    this.opacity,
    this.backgroundColor,
    this.blur = 5,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Color newBackgroundColor = backgroundColor ?? themeCubit.surfaceColor();
    Widget newChild = child;

    if (opacity != null) {
      newChild = Container(
        decoration: BoxDecoration(
          color: newBackgroundColor.withOpacity(opacity!),
          borderRadius: borderRadius,
          border: border,
        ),
        child: child,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: newChild,
      ),
    );
  }
}
