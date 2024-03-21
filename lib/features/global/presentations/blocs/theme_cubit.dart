import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../injector/injector.dart';
import '../../domain/enums/dark_mode_enum.dart';
import '../mixins/dark_mode_mixin.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with DarkModeMixin {
  final platformDispatcher = WidgetsBinding.instance.platformDispatcher;

  ThemeCubit() : super(ThemeState(userService.themeMode)) {
    final bool enable = userService.navigators.first.value == "System";
    _platformBrightnessListener(enable: enable);
  }

  changeTheme(DarkMode darkMode) {
    final themeMode = getThemeMode(darkMode);
    if (state.themeMode != themeMode) emit(ThemeState(themeMode));

    _platformBrightnessListener(enable: darkMode == DarkMode.system);
  }

  /// Change app theme whenever device theme is changed too
  _platformBrightnessListener({bool enable = true}) {
    platformDispatcher.onPlatformBrightnessChanged = enable ? _applySystemBrightness : () {};
  }

  _applySystemBrightness() {
    final bool light = platformDispatcher.platformBrightness == Brightness.light;
    if (light) return emit(ThemeState.light());
    emit(ThemeState.dark());
  }

  /// Get background color according to the theme mode
  Color surfaceColor({Color? light, Color? dark}) =>
      state.themeMode == ThemeMode.light ? light ?? white : dark ?? black;

  /// Get color of the item lying upon background according to the theme mode
  Color onSurfaceColor({Color? light, Color? dark}) =>
      state.themeMode == ThemeMode.light ? dark ?? black : light ?? white;
}
