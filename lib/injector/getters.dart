part of "injector.dart";

/// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();

/// Singleton Class
Initializer get initializer => Initializer();
ScreenSize get screen => ScreenSize();

/// Core
LocalDatabase get localDatabase => getIt<LocalDatabase>();
NetworkStatus get networkStatus => getIt<NetworkStatus>();
UserService get userService => getIt<UserService>();
AppRouter get appRouter => getIt<AppRouter>();
AuthGuard get authGuard => getIt<AuthGuard>();
