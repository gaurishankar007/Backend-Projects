import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/utils/screen.dart';

class SettingValueContainer extends StatelessWidget {
  final Widget child;
  const SettingValueContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    /// Listening to theme Changes
    Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.propHeight,
        horizontal: Screen.horizontalPadding,
      ),
      padding: EdgeInsets.all(padding15),
      decoration: BoxDecoration(
        color: onPopUpColor,
        borderRadius: BorderRadius.circular(border10),
      ),
      child: child,
    );
  }
}
