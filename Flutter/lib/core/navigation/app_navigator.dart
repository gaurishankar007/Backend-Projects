import 'package:flutter/material.dart' show debugPrint;
import 'package:get_it/get_it.dart';

import '../../config/routes/routes.dart';
import '../../config/routes/routes.gr.dart';

part 'routes_data.dart';

class AppNavigator {
  static final AppRouter _appRouter = GetIt.I<AppRouter>();

  /// Pops the page which is at the top of the pages stack
  static popPage() => _appRouter.maybePopTop();

  /// removes the second last page
  static removeLast() => _appRouter.removeLast();

  /// Pushes the page that matches the path name
  static popUntil(String routeName) =>
      _appRouter.popUntil((route) => route.settings.name == routeName);

  /// Pushes the page that matches the path name
  static removeWhere(String routeName) =>
      _appRouter.removeWhere((route) => route.name == routeName);

  /// Pushes the page that matches the path name
  static pushName(String path) => _appRouter.pushNamed(path);

  /// Pops all pages and pushes the dashboard page
  static replaceToDashboard() => _appRouter.replaceAll([const DashboardRoute()]);

  /// Pops all pages and pushes the signIn page
  static replaceToSignIn() => _appRouter.replaceAll([const SignInRoute()]);

  /// Pushes the page that matches the path name
  /// with or without argument
  /// with route name
  /// For nested navigation
  static pushRoute(String routePath, {dynamic arg}) {
    try {
      switch (routePath) {
        case SIGN_IN_PATH:
          return _appRouter.push(const SignInRoute());

        default:
          return debugPrint("Route not found.");
      }
    } catch (error) {
      return debugPrint(error.toString());
    }
  }
}
