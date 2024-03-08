import 'package:flutter/material.dart';

import '../../config/routes/setting_route.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/constant.dart';
import '../../core/constants/routes_data.dart';

showSettingBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    barrierColor: black.withOpacity(.1),
    scrollControlDisabledMaxHeightRatio: .9,
    useSafeArea: true,
    builder: (_) => ClipRRect(
      borderRadius: BorderRadius.circular(border10),
      child: Navigator(
        key: SettingRoute.navigator,
        initialRoute: kSettingPath,
        onGenerateRoute: SettingRoute.routes,
      ),
    ),
  );
}
