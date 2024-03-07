part of "injector.dart";

final getIt = GetIt.instance;

initializeDependencies() {
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Bloc
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<SettingCubit>(() => SettingCubit());

  // DataSources
  getIt.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSourceImplementation(dio: getIt()));
  getIt.registerLazySingleton<AuthLocalSource>(() => AuthLocalSourceImplementation());

  // RepoImpl
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
        remote: getIt<AuthRemoteSource>(),
        local: getIt<AuthLocalSource>(),
      ));
}
