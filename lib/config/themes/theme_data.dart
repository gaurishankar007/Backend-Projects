import '../../core/constants/colors.dart';
import 'package:flutter/material.dart';

// InputDecoration
final outlineBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(10),
);

final inputDecorationTheme = InputDecorationTheme(
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

