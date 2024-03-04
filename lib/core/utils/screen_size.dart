import 'package:flutter/material.dart' show BoxConstraints;
import 'package:chat/injection/injector.dart';

class ScreenSize {
  double _height = 0;
  double _width = 0;
  bool _isTablet = false;

  ScreenSize._();
  static final _singleton = ScreenSize._();
  factory ScreenSize() => _singleton;

  init(BoxConstraints constraints) {
    _height = constraints.maxHeight;
    _width = constraints.maxWidth;

    _isTablet = appData.isTablet;
  }

  double get height => _height;
  double get width => _width;
  bool get isTablet => _isTablet;

  /// Required percentage of height according the screen height
  double heightPercentage(double percentage) => percentage / 100 * _height;

  /// Required percentage of width according the screen width
  double widthPercentage(double percentage) => percentage / 100 * _width;

  /// proportionate height of the screen according the height of the Design (Figma)
  double proportionateHeight(double height) => (height / 949) * _height;

  /// proportionate width of the screen according the width of the Design (Figma)
  double proportionateWidth(double width) => (width / 430) * _width;

  /// Get the required number
  double _numberWithinLimitation(double number, {double? min, double? max}) {
    if (min != null && number < min) return min;
    if (max != null && number > max) return max;
    return number;
  }

  /// Required percentage of height with limitation
  double heightPercentageWithConstraints(double percentage, {double? min, double? max}) {
    double height = percentage / 100 * _height;
    return _numberWithinLimitation(height, min: min, max: max);
  }

  /// Required percentage of width with limitation
  double widthPercentageWithConstraints(double percentage, {double? min, double? max}) {
    double width = percentage / 100 * _width;
    return _numberWithinLimitation(width, min: min, max: max);
  }

  /// proportionate height with limitation
  double proportionateHeightWithConstraints(double height, {double? min, double? max}) {
    double newHeight = proportionateHeight(height);
    return _numberWithinLimitation(newHeight, min: min, max: max);
  }

  /// proportionate width with limitation
  double proportionateWidthWithConstraints(double width, {double? min, double? max}) {
    double newWidth = proportionateWidth(width);
    return _numberWithinLimitation(newWidth, min: min, max: max);
  }
}
