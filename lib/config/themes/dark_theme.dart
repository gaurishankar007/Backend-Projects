import '../../core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'theme_data.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kBlack,
  useMaterial3: false,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: kFillD,
    hintStyle: const TextStyle(color: kHintD),
  ),
  textButtonTheme: textButtonTheme,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: kWhite,
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kEBgD,
      foregroundColor: kWhite,
      splashFactory: NoSplash.splashFactory,
    ),
  ),
);
