part of "injector.dart";

final getIt = GetIt.instance;

initDependencies() {
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Bloc
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());

  // RepoImpl
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
}

AppData get appData => AppData();
NetworkService get network => NetworkService();
SConstraint get sCon => SConstraint();

AppRouter get appRouter => getIt<AppRouter>();
Dio get dio => getIt<Dio>();

// Bloc
ThemeCubit get themeCubit => getIt<ThemeCubit>();
AuthCubit get authCubit => getIt<AuthCubit>();

// RepoImpl
AuthRepo get authRepoImpl => getIt<AuthRepo>();
