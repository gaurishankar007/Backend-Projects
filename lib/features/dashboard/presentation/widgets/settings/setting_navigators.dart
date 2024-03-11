import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../injection/injector.dart';
import 'setting_navigation_item.dart';

class SettingNavigators extends StatelessWidget {
  const SettingNavigators({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.propHeight),
      padding: EdgeInsets.all(padding10),
      decoration: BoxDecoration(
        color: onPopUpColor(context),
        borderRadius: BorderRadius.circular(border10),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userService.navigationModels.length,
        separatorBuilder: (context, index) => Divider(indent: 10.wPercentage),
        itemBuilder: (context, index) {
          final navigationItem = userService.navigationModels[index];
          return SettingNavigationItem(navigationItem: navigationItem);
        },
      ),
    );
  }
}
