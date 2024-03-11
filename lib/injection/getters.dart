part of "injector.dart";

AppInitializer get appData => AppInitializer();
NetworkConnection get network => NetworkConnection();
UserService get userService => UserService();
ScreenSize get screen => ScreenSize();
AppRouter get appRouter => getIt<AppRouter>();
Dio get dio => getIt<Dio>();

/// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();

/// Repository Implementation
AuthRepository get authRepositoryImplementation => getIt<AuthRepository>();
