import 'package:auto_route/auto_route.dart';
import 'auth_guard.dart';
import 'route_transitions.dart';
import '../../core/constants/routes_data.dart';
import 'package:flutter/material.dart';
import 'routes.gr.dart';

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
        slideTransitionRoute(
          page: SignUpRoute.page,
          path: kSignUpPath,
          direction: AxisDirection.left,
        ),
        slideTransitionRoute(
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
      ];
}
