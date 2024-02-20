import '../../core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'theme_data.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: blackColor,
  useMaterial3: false,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: textFormFillDarkColor,
    hintStyle: TextStyle(color: textFormHintTextDarkColor),
  ),
  textButtonTheme: textButtonTheme,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: whiteColor,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: elevatedButtonBackgroundDarkColor,
      foregroundColor: whiteColor,
      splashFactory: NoSplash.splashFactory,
    ),
  ),
);
