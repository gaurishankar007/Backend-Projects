part of "injector.dart";

final getIt = GetIt.instance;

initializeDependencies() {
  getIt.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImplementation());
  getIt.registerLazySingleton<NetworkStatus>(() =>
      NetworkStatus(internetChecker: InternetConnectionChecker(), connectivity: Connectivity()));
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<NetworkService>(() => NetworkServiceImplementation(dio: Dio()));

  // Bloc
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // DataSources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(networkService: getIt<NetworkService>()));
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImplementation(localDatabase: getIt<LocalDatabase>()));

  // Repository Implementation
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
        networkStatus: getIt<NetworkStatus>(),
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDataSource>(),
      ));
}
