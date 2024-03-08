import 'package:flutter/material.dart' show debugPrint;

import '../../config/routes/routes.gr.dart';
import '../../injection/injector.dart';
import '../constants/routes_data.dart';

/// Pops the page which is at the top of the pages stack
popPage() => appRouter.popTop();

/// Pushes the page that matches the path name
pushName(String path) => appRouter.pushNamed(path);

/// Pops all pages and pushes the dashboard page
replaceToDashboard() => appRouter.replaceAll([DashboardRoute()]);

/// Pops all pages and pushes the signIn page
replaceToSignIn() => appRouter.replaceAll([const SignInRoute()]);

/// Pushes the page that matches the path name
/// with or without argument
/// with route name
/// For nested navigation
pushRoute(String routePath, {dynamic arg}) {
  try {
    switch (routePath) {
      case kSignInPath:
        return appRouter.push(const SignInRoute());

      default:
        return debugPrint("Route not found.");
    }
  } catch (error) {
    return debugPrint(error.toString());
  }
}
