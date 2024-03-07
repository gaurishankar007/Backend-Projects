import 'package:flutter/material.dart';

import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../data/models/drawer_navigation_model.dart';

class DrawerNavigationItem extends StatelessWidget {
  final Color backgroundColor;
  final DrawerNavigationModel navigationItem;

  DrawerNavigationItem({
    super.key,
    required this.backgroundColor,
    required this.navigationItem,
  });

  final double iconContainerSize = 40.pWConstraint(max: 45, min: 38);

  @override
  Widget build(BuildContext context) {
    final Color iconContainerColor =
        context.surfaceColor(light: const Color(0XFFEBEBEB), dark: const Color(0XFF767676));

    return Ink(
      padding: EdgeInsets.all(padding10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(border15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(padding8),
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
