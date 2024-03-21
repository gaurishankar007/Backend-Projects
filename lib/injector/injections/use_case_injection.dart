part of '../injector.dart';

_registerUseCases() {
  /// Auth
  getIt.registerLazySingleton(() => SignInUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(() => GetUserDataUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(() => SaveUserDataUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(() => GetUserSettingUseCase(authRepository: getIt()));
  getIt.registerLazySingleton(() => SaveUserSettingUseCase(authRepository: getIt()));
}
