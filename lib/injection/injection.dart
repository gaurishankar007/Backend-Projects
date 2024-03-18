part of "injector.dart";

final getIt = GetIt.instance;

initializeDependencies() {
  getIt.registerLazySingleton(
    () => NetworkStatus(
      internetConnectionChecker: InternetConnectionChecker(),
      connectivity: Connectivity(),
    ),
  );
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Bloc
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // DataSources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(dio: getIt<Dio>()));
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImplementation(localDatabase: localDatabaseImplementation));

  // Repository Implementation
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
        networkStatus: getIt<NetworkStatus>(),
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDataSource>(),
      ));
}
