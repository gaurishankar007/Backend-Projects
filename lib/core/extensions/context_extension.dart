import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Brightness get brt => Theme.of(this).brightness;
}
