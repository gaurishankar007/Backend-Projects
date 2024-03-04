import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.dark());
  // {
  //   platformDispatcher.onPlatformBrightnessChanged = listenPB;
  // }

  toggleTheme() => emit(state.toggle);

  /// Get background color according to the theme mode
  Color surfaceColor({Color? light, dark}) =>
      state.themeMode == ThemeMode.light ? light ?? kWhite : dark ?? kBlack;

  /// Get color of the item lying upon background according to the theme mode
  Color onSurfaceColor({Color? light, dark}) =>
      state.themeMode == ThemeMode.light ? light ?? kBlack : dark ?? kWhite;
}
