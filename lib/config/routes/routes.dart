import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/navigation/navigator.dart';
import 'helper/auth_guard.dart';
import 'helper/sliding_auto_route.dart';
import 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page, Route")
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: SignInRoute.page,
          path: SIGN_IN_PATH,
        ),
        slidingRoute(
          page: SignUpRoute.page,
          path: SIGN_UP_PATH,
          direction: AxisDirection.left,
        ),
        slidingRoute(
          page: UpdateProfileRoute.page,
          path: UPDATE_PROFILE_PATH,
          direction: AxisDirection.left,
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: DASHBOARD_PATH,
          initial: true,
          guards: [AuthGuard()],
        ),
      ];
}
