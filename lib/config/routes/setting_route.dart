import 'package:flutter/material.dart';

import '../../core/constants/routes_data.dart';
import '../../features/setting/domain/parameters/setting_parameter.dart';
import '../../features/setting/presentation/pages/active_status.dart';
import '../../features/setting/presentation/pages/app_lock.dart';
import '../../features/setting/presentation/pages/dark_mode_selection.dart';
import '../../features/setting/presentation/pages/page_not_found.dart';
import '../../features/setting/presentation/pages/settings.dart';
import 'helper/custom_page_route.dart';

class SettingRoute {
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case kSettingPath:
        return _materialRoute(const Settings());

      case kDarkModePath:
        return _customRoute(
          child: DarkModeSelection(parameter: settings.arguments as SettingParameter),
          direction: AxisDirection.left,
        );

      case kActiveStatusPath:
        return _customRoute(
          child: ActiveStatus(parameter: settings.arguments as SettingParameter),
          direction: AxisDirection.left,
        );

      case kAppLockPath:
        return _customRoute(
          child: AppLock(parameter: settings.arguments as SettingParameter),
          direction: AxisDirection.left,
        );
    }

    return _customRoute(child: const PageNotFound(), direction: AxisDirection.left);
  }

  static Route<dynamic> _materialRoute(Widget child) =>
      MaterialPageRoute(builder: (builder) => child);

  static Route<dynamic> _customRoute({required Widget child, required AxisDirection direction}) =>
      CustomPageRoute(child: child, direction: direction);
}
