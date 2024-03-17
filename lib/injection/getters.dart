part of "injector.dart";

Initializer get initializer => Initializer();
ConnectivityService get connectivityService => ConnectivityService();
UserService get userService => UserService();
ScreenSize get screen => ScreenSize();
AppRouter get appRouter => getIt<AppRouter>();
Dio get dio => getIt<Dio>();

/// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();

/// Repository Implementation
AuthRepository get authRepositoryImplementation => getIt<AuthRepository>();
