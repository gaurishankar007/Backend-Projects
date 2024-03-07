import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/extensions/context_extension.dart';

class GlassLayer extends StatelessWidget {
  final double? opacity;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final double? height;
  final EdgeInsets? padding;
  final double blur;
  final Widget child;

  const GlassLayer({
    super.key,
    this.opacity,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.height,
    this.padding,
    this.blur = 5,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Color newBackgroundColor = backgroundColor ?? context.surfaceColor();
    Widget newChild = child;

    if (opacity != null) {
      newChild = Container(
        height: height,
        padding: padding,
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
