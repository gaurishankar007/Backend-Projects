import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final platformDispatcher = WidgetsBinding.instance.platformDispatcher;

  ThemeCubit() : super(ThemeState.system());
  // {
  //   platformDispatcher.onPlatformBrightnessChanged = listenPB;
  // }

  toggleTheme() {
    emit(state.toggle);
  }

  listenPB() {
    platformDispatcher.platformBrightness == Brightness.light
        ? emit(ThemeState.light())
        : emit(ThemeState.dark());
  }

  Color tColor({Color? light, dark}) =>
      state.themeMode == ThemeMode.light ? light ?? kBlack : dark ?? kWhite;
}
