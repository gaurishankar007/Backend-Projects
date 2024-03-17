part of "injector.dart";

final getIt = GetIt.instance;

initializeDependencies() {
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Bloc
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // DataSources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(dio: getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImplementation());

  // Repository Implementation
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
        connectivityService: connectivityService,
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDataSource>(),
      ));
}
