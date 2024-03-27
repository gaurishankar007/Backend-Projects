part of '../injector.dart';

_registerCores() {
  getIt.registerLazySingleton<NetworkStatus>(
    () => NetworkStatus(internetConnectionChecker: getIt(), connectivity: getIt()),
  );
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<AuthGuard>(() => AuthGuard(userService: getIt()));
  getIt.registerLazySingleton(
    () => UserService(
      getUserDataUseCase: getIt(),
      getUserSettingUseCase: getIt(),
      saveUserSettingUseCase: getIt(),
    ),
  );
  getIt.registerLazySingleton<NetworkService>(() => NetworkServiceImplementation(dio: Dio()));
  getIt.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImplementation());
}
