import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart' show CupertinoActivityIndicator;

import '../extensions/int_extension.dart';
import '../../injection/injector.dart';
import '../utils/text_styles.dart';

class EvButton extends StatelessWidget {
  final Function() onTap;
  final double? height;
  final double? width;
  final String text;
  final IconData? icon;
  final bool disabled;
  final bool showLoading;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? elevation;
  final bool expandWidth;

  const EvButton({
    super.key,
    required this.onTap,
    this.text = "",
    this.height,
    this.width,
    this.textStyle,
    this.textColor,
    this.color,
    this.disabled = false,
    this.showLoading = false,
    this.icon,
    this.borderColor,
    this.borderRadius,
    this.elevation,
    this.expandWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    Color? tColor = textColor;

    Widget child = Text(text, style: textStyle ?? lgSemibold(tColor));
    if (icon != null) {
      if (text.isEmpty) {
        child = Icon(icon!, color: tColor);
      } else {
        child = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(icon!, color: tColor),
            ),
            child,
          ],
        );
      }
    }

    Widget loadingChild = Center(
      child: SizedBox(
        height: 25.pH,
        width: 25.pH,
        child: psLoading(themeBloc.tColor()),
      ),
    );

    return SizedBox(
      height: height ?? 70.pH,
      width: expandWidth ? width ?? double.maxFinite : null,
      child: StatefulBuilder(
        builder: (context, setState) {
          Function()? onPressed;
          if (loading) onPressed = () {};

          if (!loading && !disabled) {
            onPressed = () async {
              if (showLoading) setState(() => loading = true);
              await onTap();
              if (showLoading) setState(() => loading = false);
            };
          }

          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10),
              ),
              elevation: elevation ?? 0,
              shadowColor: elevation != null ? null : Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: loading ? loadingChild : child,
          );
        },
      ),
    );
  }

  Widget psLoading(Color color) => Platform.isIOS
      ? CupertinoActivityIndicator(color: color)
      : CircularProgressIndicator(color: color, strokeWidth: 2);
}
