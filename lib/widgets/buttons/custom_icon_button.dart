import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final Icon icon;
  final bool disableSplash;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.disableSplash = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      icon: icon,
    );

    if (disableSplash) {
      child = Theme(
        data: ThemeData(splashFactory: NoSplash.splashFactory),
        child: child,
      );
    }

    return child;
  }
}
