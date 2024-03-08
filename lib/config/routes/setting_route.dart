import 'package:flutter/material.dart';

import '../../core/constants/routes_data.dart';
import '../../features/dashboard/data/models/settingNavigation/setting_navigation_model.dart';
import '../../features/dashboard/presentation/pages/settings/active_status.dart';
import '../../features/dashboard/presentation/pages/settings/app_lock.dart';
import '../../features/dashboard/presentation/pages/settings/dark_mode_selection.dart';
import '../../features/dashboard/presentation/pages/settings/page_not_found.dart';
import '../../features/dashboard/presentation/pages/settings/settings.dart';
import 'helper/custom_page_route.dart';

class SettingRoute {
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case kSettingPath:
        return _materialRoute(const Settings());

      case kDarkModePath:
        return _customRoute(
          child: DarkModeSelection(navigationModel: settings.arguments as SettingNavigationModel),
          direction: AxisDirection.left,
        );

      case kActiveStatusPath:
        return _customRoute(
          child: ActiveStatus(navigationModel: settings.arguments as SettingNavigationModel),
          direction: AxisDirection.left,
        );

      case kAppLockPath:
        return _customRoute(
          child: AppLock(navigationModel: settings.arguments as SettingNavigationModel),
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
