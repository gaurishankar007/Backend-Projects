import 'package:chat/injection/injector.dart';
import 'package:flutter/material.dart' show Curve, Curves;

/// Icon
double get navigatorIconSize => 28;

/// Page Padding
double get horizontalPadding => screenSize.widthPercentage(5);
double get tabletHorizontalPadding => screenSize.widthPercentage(17.5);
double get dynamicHorizontalPadding =>
    screenSize.isTablet ? tabletHorizontalPadding : horizontalPadding;

/// Page Transition
Duration get pageTransitionDuration => const Duration(milliseconds: 200);
Curve get pageTransitionCurve => Curves.easeInOut;
