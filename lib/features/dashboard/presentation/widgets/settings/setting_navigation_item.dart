import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/utils/navigator.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../data/models/settingNavigation/setting_navigation_model.dart';

class SettingNavigationItem extends StatelessWidget {
  final SettingNavigationModel settingItem;
  const SettingNavigationItem({super.key, required this.settingItem});

  @override
  Widget build(BuildContext context) {
    /// Color of the container containing the leading icon
    Color containerColor = settingItem.backgroundColor;
    if (settingItem.backgroundColor == Colors.transparent) {
      containerColor = context.onSurfaceColor(
        dark: Colors.black,
        light: const Color(0XFF595959),
      );
    }
    final Color arrowColor = context.surfaceColor(
      dark: const Color(0XFF595959),
      light: const Color(0XFFCCCCCC),
    );
    final Color valueColor = context.onSurfaceColor(
      light: const Color(0XFF888888),
      dark: const Color(0XFF808080),
    );

    return ListTile(
      onTap: () => pushRoute(settingItem.routePath),
      horizontalTitleGap: 8,
      leading: Container(
        padding: EdgeInsets.all(padding5),
        decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
        child: Icon(settingItem.iconData, size: 18, color: white),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(settingItem.title, style: largeRegular()),
          Text(settingItem.value, style: largeRegular(valueColor)),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: arrowColor, size: 15),
    );
  }
}
