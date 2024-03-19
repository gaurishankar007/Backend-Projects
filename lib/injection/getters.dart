part of "injector.dart";

Initializer get initializer => Initializer();
UserService get userService => UserService();
ScreenSize get screen => ScreenSize();

LocalDatabase get localDatabase => getIt<LocalDatabase>();
NetworkStatus get networkStatus => getIt<NetworkStatus>();
AppRouter get appRouter => getIt<AppRouter>();

/// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();

/// Repository Implementation
AuthRepository get authRepositoryImplementation => getIt<AuthRepository>();
