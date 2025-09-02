part of '../injector.dart';

_registerBlocs() {
  /// Theme
  getIt.registerLazySingleton(() => ThemeCubit());

  /// Auth
  getIt.registerFactory(() => SignInCubit(signInUseCase: getIt(), userService: getIt()));
  getIt.registerFactory(() => SignUpCubit(signUpUseCase: getIt(), userService: getIt()));
  getIt.registerFactory(() => UpdateProfileCubit(
        updateProfileUseCase: getIt(),
        saveUserDataUseCase: getIt(),
        userService: getIt(),
      ));
}
