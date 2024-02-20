part of "injector.dart";

AppData get appData => AppData();
NetworkConnection get network => NetworkConnection();
ScreenSize get screenSize => ScreenSize();

AppRouter get appRouter => getIt<AppRouter>();
Dio get dio => getIt<Dio>();

// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();
AuthCubit get authCubit => getIt<AuthCubit>();

// Repository Implementation
AuthRepository get authRepositoryImplementation => getIt<AuthRepository>();
