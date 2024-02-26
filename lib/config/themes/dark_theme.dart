import 'package:chat/core/utils/text_styles.dart';

import '../../core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'theme_data.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimary,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: kBlack,
  useMaterial3: false,
  appBarTheme: appBarTheme.copyWith(
    titleTextStyle: largeMedium(kWhite),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: kBlack,
    ),
  ),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: kFormFillDark,
    hintStyle: TextStyle(color: kFormHintDark),
  ),
  textButtonTheme: textButtonTheme,
  iconButtonTheme: iconButtonTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kButtonDark,
      foregroundColor: kWhite,
      splashFactory: NoSplash.splashFactory,
    ),
  ),
);
