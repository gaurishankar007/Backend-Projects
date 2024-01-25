import 'package:auto_route/auto_route.dart';
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
          path: signInP,
          initial: true,
        ),
        autoRouteTransition(
          page: SignUpRoute.page,
          path: signUpP,
          direction: AxisDirection.left,
        ),
      ];
}
