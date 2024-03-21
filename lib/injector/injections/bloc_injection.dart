part of '../injector.dart';

_registerBlocs() {
  /// Theme
  getIt.registerLazySingleton(() => ThemeCubit());
}
