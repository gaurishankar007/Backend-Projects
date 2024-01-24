import 'package:chat/core/constants/colors.dart';
import 'package:flutter/material.dart';

// InputDecoration
const outlineBorder = OutlineInputBorder(borderSide: BorderSide.none);
const inputDecorationTheme = InputDecorationTheme(
  isDense: true,
  filled: true,
  enabledBorder: outlineBorder,
  focusedBorder: outlineBorder,
  errorBorder: outlineBorder,
  focusedErrorBorder: outlineBorder,
  disabledBorder: outlineBorder,
);

final textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    foregroundColor: kPrimary,
  ),
);
