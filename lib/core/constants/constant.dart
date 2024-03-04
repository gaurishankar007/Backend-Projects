import 'package:chat/injection/injector.dart';
import 'package:flutter/material.dart' show Curve, Curves;

/// Icon
double get appBarIconSize => 22;

/// Border Radius
double get border5 => 5;
double get border8 => 8;
double get border10 => 10;
double get border15 => 15;

/// Page Padding
double get horizontalPadding => screenSize.widthPercentageWithConstraints(3, max: 15);
double get tabletHorizontalPadding => screenSize.widthPercentage(17.5);
double get dynamicHorizontalPadding =>
    screenSize.isTablet ? tabletHorizontalPadding : horizontalPadding;

/// Page Transition
Duration get pageTransitionDuration => const Duration(milliseconds: 200);
Curve get pageTransitionCurve => Curves.easeInOut;
