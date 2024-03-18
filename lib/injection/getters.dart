part of "injector.dart";

Initializer get initializer => Initializer();
UserService get userService => UserService();
ScreenSize get screen => ScreenSize();

NetworkStatus get networkStatus => getIt<NetworkStatus>();
AppRouter get appRouter => getIt<AppRouter>();
Dio get dio => getIt<Dio>();

/// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();

/// Repository Implementation
AuthRepository get authRepositoryImplementation => getIt<AuthRepository>();
