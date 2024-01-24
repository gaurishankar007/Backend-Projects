import 'package:chat/config/routes/routes.gr.dart';
import 'package:chat/injection/injector.dart';
import 'package:flutter/material.dart' show debugPrint;

import '../constants/routes_data.dart';

popPage() => appRouter.popTop();

pushName(String path) => appRouter.pushNamed(path);

popToSignIn() => appRouter.replaceAll([const SignInRoute()]);

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
