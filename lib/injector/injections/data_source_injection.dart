part of '../injector.dart';

_registerDataSources() {
  /// Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplementation(networkClient: getIt(), multiPartClient: getIt()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImplementation(localDatabase: getIt()),
  );
}
