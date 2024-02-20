import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;
}
