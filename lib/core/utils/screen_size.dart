import 'package:flutter/material.dart';

class ScreenSize {
  double _height = 0;
  double _width = 0;

  ScreenSize._();
  static final _singleton = ScreenSize._();
  factory ScreenSize() => _singleton;

  init(BoxConstraints constraints) {
    _height = constraints.maxHeight;
    _width = constraints.maxWidth;
  }

  double get height => _height;
  double get width => _width;

  /// Required percentage of height according the screen height
  double heightPercentage(double percentage) => percentage / 100 * _height;

  /// Required percentage of width according the screen width
  double widthPercentage(double percentage) => percentage / 100 * _width;

  /// proportionate height of the screen according the height of the Design (Figma)
  double proportionateHeight(double height) => (height / 949) * _height;

  /// proportionate width of the screen according the width of the Design (Figma)
  double proportionateWidth(double width) => (width / 430) * _width;

  /// proportionate height with limitation
  double proportionateHeightWithConstraints(double height, {double? min, max}) {
    double newHeight = proportionateHeight(height);

    if (min != null && newHeight < min) return min;
    if (max != null && newHeight > max) return max;
    return newHeight;
  }

  /// proportionate width with limitation
  double proportionateWidthWithConstraints(double width, {double? min, max}) {
    double newWidth = proportionateWidth(width);

    if (min != null && newWidth < min) return min;
    if (max != null && newWidth > max) return max;
    return newWidth;
  }
}
