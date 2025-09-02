import 'package:auto_route/auto_route.dart';
import 'package:chat/config/routes/helper/auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/navigation/app_navigator.dart';
import '../../core/services/user_service.dart';
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
          guards: [AuthGuard(userService: GetIt.I<UserService>())],
        ),
      ];
}
