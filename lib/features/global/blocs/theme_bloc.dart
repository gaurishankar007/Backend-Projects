import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';

part 'theme_state.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(ThemeState.light());

  toggleTheme() {
    emit(state.toggle);
  }

  Color tColor({Color? light, dark}) =>
      state.themeMode == ThemeMode.light ? light ?? kBlack : dark ?? kWhite;
}
