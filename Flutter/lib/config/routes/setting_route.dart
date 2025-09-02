import 'package:flutter/material.dart';

import '../../core/navigation/app_navigator.dart';
import '../../features/setting/presentation/arguments/setting_argument.dart';
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
      case SETTING_PATH:
        return _materialRoute(const Settings());

      case DARK_MODE_PATH:
        return _customRoute(
          child: DarkModeSelection(argument: settings.arguments as SettingArgument),
          direction: AxisDirection.left,
        );

      case ACTIVE_STATUS_PATH:
        return _customRoute(
          child: ActiveStatus(argument: settings.arguments as SettingArgument),
          direction: AxisDirection.left,
        );

      case APP_LOCK_PATH:
        return _customRoute(
          child: AppLock(parameter: settings.arguments as SettingArgument),
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
