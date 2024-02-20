import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import '../../core/constants/colors.dart';
import 'theme_data.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: whiteColor,
  useMaterial3: false,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: textFormFillLightColor,
    hintStyle: TextStyle(color: textFormHintTextLightColor),
  ),
  textButtonTheme: textButtonTheme,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: blackColor,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: elevatedButtonBackgroundLightColor,
      foregroundColor: blackColor,
      splashFactory: NoSplash.splashFactory,
      surfaceTintColor: Colors.transparent,
    ),
  ),
);
