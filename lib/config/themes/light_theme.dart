import '../../core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'theme_data.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: kWhite,
  useMaterial3: false,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: kFillL,
    hintStyle: const TextStyle(color: kHintL),
  ),
  textButtonTheme: textButtonTheme,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: kBlack,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kEBgL,
      foregroundColor: kBlack,
      splashFactory: NoSplash.splashFactory,
      surfaceTintColor: Colors.transparent,
    ),
  ),
);
