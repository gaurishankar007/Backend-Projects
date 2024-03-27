import 'package:auto_route/auto_route.dart';
import '../../../core/services/user_service.dart';
import '../routes.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final UserService userService;

  const AuthGuard({required this.userService});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final bool isLoggedIn = userService.userData.accessToken.isNotEmpty;
    if (isLoggedIn) return resolver.next(true);

    router.replaceAll([const SignInRoute()]);
  }
}
