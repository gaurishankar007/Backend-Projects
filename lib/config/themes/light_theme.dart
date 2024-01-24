import 'package:chat/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'theme_data.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: kWhite,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: kFillL,
    hintStyle: const TextStyle(color: kHintL),
  ),
  textButtonTheme: textButtonTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kEBgL,
      foregroundColor: kBlack,
      splashFactory: NoSplash.splashFactory
    ),
  ),
);
