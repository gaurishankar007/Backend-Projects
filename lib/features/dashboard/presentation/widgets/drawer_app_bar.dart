import 'package:chat/core/extensions/int_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../injection/injector.dart';
import '../../../../widgets/buttons/custom_icon_button.dart';
import '../../../../widgets/glass_layer.dart';
import '../../../../widgets/image_builder.dart';
import '../../../../widgets/modalSheets/setting_bottom_sheet.dart';

class DrawerAppBar extends StatelessWidget {
  DrawerAppBar({super.key});

  final double imageSize = 40.pWConstraint(max: 45, min: 38);
  final user = appData.userData.user;

  @override
  Widget build(BuildContext context) {
    final Color surfaceColor = themeCubit.surfaceColor();

    return GlassLayer(
      child: AppBar(
        backgroundColor: surfaceColor.withOpacity(.05),
        leading: Align(
          alignment: Alignment.centerRight,
          child: ImageBuilder(
            height: imageSize,
            width: imageSize,
            circular: true,
            imageUrl: "$profileUrl/${user.profile}",
          ),
        ),
        leadingWidth: horizontalPadding + imageSize,
        title: Text(user.name),
        titleSpacing: 10.pWConstraint(max: 15),
        actions: [
          CustomIconButton(
            onPressed: () => showSettingBottomSheet(context),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            disableSplash: true,
            icon: Icon(Icons.settings_rounded, color: kPrimary, size: appBarIconSize),
          ),
        ],
      ),
    );
  }
}
