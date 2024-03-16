import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../injection/injector.dart';
import 'setting_navigation_item.dart';

class SettingNavigators extends StatelessWidget {
  const SettingNavigators({super.key});

  @override
  Widget build(BuildContext context) {
    /// Listening Theme Changes
    Theme.of(context);

    Color arrowColor = surfaceColor(dark: const Color(0XFF595959), light: const Color(0XFFCCCCCC));
    Color valueColor =
        onSurfaceColor(light: const Color(0XFF888888), dark: const Color(0XFF808080));

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.propHeight),
      padding: EdgeInsets.all(padding10),
      decoration: BoxDecoration(
        color: onPopUpColor,
        borderRadius: BorderRadius.circular(border10),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userService.navigators.length,
        separatorBuilder: (context, index) => Divider(indent: 10.wPercentage),
        itemBuilder: (context, index) {
          return SettingNavigationItem(
            navigationItem: userService.navigators[index],
            arrowColor: arrowColor,
            valueColor: valueColor,
          );
        },
      ),
    );
  }
}
