import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/user_service.dart';
import '../../../../injection/injector.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with ThemeModeFromValue {
  final platformDispatcher = WidgetsBinding.instance.platformDispatcher;

  ThemeCubit() : super(ThemeState(userService.themeMode)) {
    final bool enable = userService.navigationModels.first.value == "System";
    _platformBrightnessListener(enable: enable);
  }

  changeTheme(String darkMode) {
    final themeMode = getThemeMode(darkMode);
    emit(ThemeState(themeMode));

    _platformBrightnessListener(enable: darkMode == "System");
  }

  _platformBrightnessListener({bool enable = true}) {
    platformDispatcher.onPlatformBrightnessChanged = enable ? _applySystemBrightness : () {};
  }

  _applySystemBrightness() {
    final bool light = platformDispatcher.platformBrightness == Brightness.light;
    if (light) return emit(ThemeState.light());
    emit(ThemeState.dark());
  }
}
