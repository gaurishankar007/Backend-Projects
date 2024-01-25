import '../extensions/int_extension.dart';
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class CusTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final TextStyle? titleStyle;
  final double? height;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String?)? onChanged;
  final String? initialValue;
  final InputDecoration? inputDecoration;

  const CusTextForm({
    super.key,
    this.controller,
    this.title,
    this.titleStyle,
    this.height,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.initialValue,
    this.inputDecoration,
  });

  @override
  Widget build(BuildContext context) {
    double newHeight = height ?? 70.pH;

    Widget child = SizedBox(
      height: newHeight,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        initialValue: initialValue,
        obscureText: obscureText,
        decoration: inputDecoration,
      ),
    );

    if (title == null) return child;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title!, style: titleStyle ?? xlSemibold()),
        SizedBox(height: 15.pH),
        child,
      ],
    );
  }
}
