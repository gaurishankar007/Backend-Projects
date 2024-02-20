import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.system());
  // {
  //   platformDispatcher.onPlatformBrightnessChanged = listenPB;
  // }

  toggleTheme() => emit(state.toggle);

  /// Get color according to the theme mode
  Color themeColor({Color? light, dark}) =>
      state.themeMode == ThemeMode.light ? light ?? blackColor : dark ?? whiteColor;
}
