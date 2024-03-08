import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/text_styles.dart';

class SettingSelection extends StatelessWidget {
  final String value;
  final bool selected;
  final Function() onPressed;

  const SettingSelection({
    super.key,
    required this.value,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: largeRegular()),
          if (selected) Icon(Icons.check_rounded, color: primaryColor, size: 18)
        ],
      ),
    );
  }
}
