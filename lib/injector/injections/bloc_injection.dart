part of '../injector.dart';

_registerBlocs() {
  /// Theme
  getIt.registerLazySingleton(() => ThemeCubit());

  /// Auth
  getIt.registerLazySingleton(
    () => AuthCubit(
      dependency: AuthCubitDependency(
        signInUseCase: getIt(),
        signUpUseCase: getIt(),
        updateProfileUseCase: getIt(),
        saveUserDataUseCase: getIt(),
        saveUserSettingUseCase: getIt(),
        userService: getIt(),
      ),
    ),
  );
}
