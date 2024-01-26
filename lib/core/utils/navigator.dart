import 'package:flutter/material.dart' show debugPrint;

import '../../config/routes/routes.gr.dart';
import '../../injection/injector.dart';
import '../constants/routes_data.dart';

popPage() => appRouter.popTop();

pushName(String path) => appRouter.pushNamed(path);

replaceToDashboard() => appRouter.replaceAll([const DashboardRoute()]);

replaceToSignIn() => appRouter.replaceAll([const SignInRoute()]);

pushRoute(String route, {dynamic arg}) {
  try {
    switch (route) {
      case signInP:
        return appRouter.push(const SignInRoute());

      default:
        return debugPrint("Route not found.");
    }
  } catch (error) {
    debugPrint(error.toString());
    return;
  }
}
