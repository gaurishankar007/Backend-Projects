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

  final Color iconContainerColor = themeCubit.onSurfaceColor(
    light: kOnButtonContainerLight,
    dark: kOnButtonContainerDark,
  );
  final double iconContainerSize = 40.pWConstraint(max: 45, min: 38);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(border15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: iconContainerSize,
            width: iconContainerSize,
            decoration: BoxDecoration(
              color: iconContainerColor,
              borderRadius: BorderRadius.circular(border10),
            ),
            child: Icon(navigationItem.iconData, size: 20),
          ),
          SizedBox(width: 15.pWConstraint(max: 15)),
          Text(navigationItem.name, style: largeMedium())
        ],
      ),
    );
  }
}
