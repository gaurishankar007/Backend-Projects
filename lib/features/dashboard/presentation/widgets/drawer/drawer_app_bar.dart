import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../injection/injector.dart';
import '../../../../../widgets/buttons/custom_icon_button.dart';
import '../../../../../widgets/glass_layer.dart';
import '../../../../../widgets/modalSheets/setting_bottom_sheet.dart';
import '../../../../../widgets/user/user_image.dart';
import '../../../../../widgets/user/user_name.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Color drawerColor = context.surfaceColor(
      light: Colors.white,
      dark: const Color(0XFF303030),
    );
    return GlassLayer(
      opacity: .05,
      backgroundColor: drawerColor,
      height: kToolbarHeight + screen.statusBarHeight,
      padding: EdgeInsets.only(
        top: screen.statusBarHeight,
        left: screen.horizontalPadding,
        right: screen.horizontalPadding,
      ),
      child: Row(
        children: [
          UserCircularImage(diameter: 40.pWConstraint(max: 45, min: 38)),
          SizedBox(width: 10.pWConstraint(max: 15)),
          const UserName(),
          const Spacer(),
          CustomIconButton(
            onPressed: () => showSettingBottomSheet(context),
            padding: EdgeInsets.symmetric(horizontal: screen.horizontalPadding),
            disableSplash: true,
            icon: Icon(Icons.settings_rounded, color: primaryColor, size: appBarIconSize),
          ),
        ],
      ),
    );
  }
}
