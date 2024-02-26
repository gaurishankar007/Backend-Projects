import '../../core/constants/colors.dart';
import 'package:flutter/material.dart';

/// <===== AppBarTheme =====>
AppBarTheme get appBarTheme => const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    );

/// <===== TextFormField InputDecoration =====>
/// Border
OutlineInputBorder get outlineBorder => OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    );

/// Input Decoration
InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
      filled: true,
      enabledBorder: outlineBorder,
      focusedBorder: outlineBorder,
      errorBorder: outlineBorder,
      focusedErrorBorder: outlineBorder,
      disabledBorder: outlineBorder,
    );

/// <===== TextButton Theme Style =====>
TextButtonThemeData get textButtonTheme => TextButtonThemeData(
      style: TextButton.styleFrom(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        foregroundColor: kPrimary,
      ),
    );

/// <===== TextButton Theme Style =====>
IconButtonThemeData get iconButtonTheme => IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        splashFactory: NoSplash.splashFactory,
      ),
    );
