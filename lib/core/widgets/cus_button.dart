import 'dart:io';

import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart' show CupertinoActivityIndicator;

import '../constants/colors.dart';
import '../utils/text_styles.dart';

class CusButton extends StatelessWidget {
  final Function() onTap;
  final double? height;
  final double? width;
  final String text;
  final IconData? icon;
  final bool disabled;
  final bool loadableButton;
  final TextStyle? textStyle;
  final Color? color;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? elevation;
  final bool expandWidth;

  const CusButton({
    super.key,
    required this.onTap,
    this.text = "",
    this.height,
    this.width,
    this.textStyle,
    this.color,
    this.disabled = false,
    this.loadableButton = false,
    this.icon,
    this.borderColor,
    this.borderRadius,
    this.elevation,
    this.expandWidth = false,
  });

  @override
  Widget build(BuildContext ctx) {
    bool loading = false;
    Color? tColor;

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
          child: CircularProgressIndicator(color: tdColor(ctx), strokeWidth: 2)),
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
              if (loadableButton) setState(() => loading = true);
              await onTap();
              if (loadableButton) setState(() => loading = false);
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
            ),
            child: loading ? loadingChild : child,
          );
        },
      ),
    );
  }

  Color tdColor(BuildContext ctx) => ctx.brt == Brightness.light ? kWhite : kBlack;
  Widget psLoading(ctx) {
    if (Platform.isIOS) return CupertinoActivityIndicator(color: tdColor(ctx));
    return CircularProgressIndicator(color: tdColor(ctx), strokeWidth: 2);
  }
}
