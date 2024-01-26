import 'package:flutter/material.dart';
import '../../utils/text_styles.dart';

class TButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final bool compressSize;
  final double? elevation;

  const TButton({
    super.key,
    required this.onPressed,
    this.text = "",
    this.color,
    this.textStyle,
    this.compressSize = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        visualDensity: compressSize ? null : const VisualDensity(),
        elevation: elevation,
      ),
      child: Text(text, style: textStyle ?? lgSemibold()),
    );
  }
}
