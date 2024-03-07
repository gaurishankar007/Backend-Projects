import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/constants/routes_data.dart';
import 'auth_guard.dart';
import 'routes.gr.dart';
import 'sliding_route.dart';

@AutoRouterConfig(replaceInRouteName: "Page, Route")
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: SignInRoute.page,
          path: kSignInPath,
        ),
        slidingRoute(
          page: SignUpRoute.page,
          path: kSignUpPath,
          direction: AxisDirection.left,
        ),
        slidingRoute(
          page: UpdateProfileRoute.page,
          path: kUpdateProfilePath,
          direction: AxisDirection.left,
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: kDashboardPath,
          initial: true,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: SettingDashboardRoute.page,
          path: kSettingDashboardPath,
          usesPathAsKey: true,
          children: [
            AutoRoute(
              page: SettingRoute.page,
              path: kSettingRoute,
              initial: true,
            ),
            slidingRoute(
              page: DarkModeRoute.page,
              path: kDarkModePath,
              direction: AxisDirection.left,
            ),
          ],
        ),
      ];
}
