import 'package:auto_route/auto_route.dart';
import 'routes.gr.dart';
import '../../injection/injector.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (appData.isLoggedIn) return resolver.next(true);

    router.replaceAll([const SignInRoute()]);
  }
}
