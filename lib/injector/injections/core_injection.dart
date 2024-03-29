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
  getIt.registerLazySingleton<NetworkClient>(() => NetworkClientImplementation(dio: Dio()));
  getIt.registerLazySingleton<MultiPartClient>(() => MultiPartClientImplementation());
  getIt.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImplementation());
}
