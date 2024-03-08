import 'package:flutter/material.dart';

import '../../domain/enums/dark_mode_enum.dart';

mixin DarkModeMixin {
  ThemeMode getThemeMode(DarkMode darkMode) {
    if (darkMode == DarkMode.on) {
      return ThemeMode.dark;
    } else if (darkMode == DarkMode.off) {
      return ThemeMode.light;
    }

    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }
}
