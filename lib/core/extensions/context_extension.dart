import 'package:flutter/material.dart';

import '../constants/colors.dart';

extension ContextExtension on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  /// Get background color according to the theme mode
  Color surfaceColor({Color? light, Color? dark}) =>
      brightness == Brightness.light ? light ?? white : dark ?? black;

  /// Get color of the item lying upon background according to the theme mode
  Color onSurfaceColor({Color? light, Color? dark}) =>
      brightness == Brightness.light ? dark ?? white : light ?? black;
}
