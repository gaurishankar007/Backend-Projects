import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import '../../core/constants/colors.dart';
import '../../core/utils/text_styles.dart';
import 'theme_data.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
  scaffoldBackgroundColor: kWhite,
  useMaterial3: false,
  appBarTheme: appBarTheme.copyWith(
    titleTextStyle: largeMedium(kBlack),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: kWhite,
    ),
  ),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: kFormFillLight,
    hintStyle: TextStyle(color: kFormHintLight),
  ),
  textButtonTheme: textButtonTheme,
  iconButtonTheme: iconButtonTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kButtonLight,
      foregroundColor: kBlack,
      splashFactory: NoSplash.splashFactory,
      surfaceTintColor: Colors.transparent,
    ),
  ),
);
