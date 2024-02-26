import 'package:chat/core/constants/constant.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extensions/int_extension.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../injection/injector.dart';
import '../../data/models/drawer_navigation_entity.dart';

class DrawerNavigationItem extends StatelessWidget {
  final Color backgroundColor;
  final DrawerNavigationModel navigationItem;

  DrawerNavigationItem({
    super.key,
    required this.backgroundColor,
    required this.navigationItem,
  });

  final iconContainerColor = themeCubit.onSurfaceColor(
    light: kOnButtonContainerLight,
    dark: kOnButtonContainerDark,
  );

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconContainerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(navigationItem.iconData, size: navigatorIconSize),
          ),
          SizedBox(width: 15.propWidth),
          Text(navigationItem.name, style: largeMedium())
        ],
      ),
    );
  }
}
