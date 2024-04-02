import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A class that stores screen height, width, screen paddings, and dynamic sizes
class Screen {
  static double _height = 0;
  static double _width = 0;
  static double _statusBarHeight = 0;
  static bool _isTablet = false;

  static double get height => _height;
  static double get width => _width;
  static double get statusBarHeight => _statusBarHeight;

  static setScreen(BoxConstraints constraints, BuildContext context) {
    _height = constraints.maxHeight;
    _width = constraints.maxWidth;

    /// Height of the system top status bar
    _statusBarHeight = MediaQuery.of(context).padding.top;

    checkDeviceType();
  }

  /// Check whether the device is tablet or smartphone
  static checkDeviceType() {
    final flutterView = WidgetsBinding.instance.platformDispatcher.views.first;

    /// Checking if device is smartphone or tablet
    double shortestSide = flutterView.physicalSize.shortestSide / flutterView.devicePixelRatio;
    _isTablet = shortestSide > 600;

    /// Setting orientation for the device
    final orientation = _isTablet ? DeviceOrientation.landscapeLeft : DeviceOrientation.portraitUp;
    SystemChrome.setPreferredOrientations([orientation]);
  }

  /// Required percentage of height according the screen height
  static double heightPercentage(double percentage) => percentage / 100 * _height;

  /// Required percentage of width according the screen width
  static double widthPercentage(double percentage) => percentage / 100 * _width;

  /// proportionate height of the screen according the height of the Design (Figma)
  static double proportionateHeight(double height) => (height / 949) * _height;

  /// proportionate width of the screen according the width of the Design (Figma)
  static double proportionateWidth(double width) => (width / 430) * _width;

  /// Get the required number within the limitation
  static double _numberWithinLimitation(double number, {double? min, double? max}) {
    if (min != null && number < min) return min;
    if (max != null && number > max) return max;
    return number;
  }

  /// Required percentage of height with limitation
  static double heightPercentageWithConstraints(double percentage, {double? min, double? max}) {
    double height = percentage / 100 * _height;
    return _numberWithinLimitation(height, min: min, max: max);
  }

  /// Required percentage of width with limitation
  static double widthPercentageWithConstraints(double percentage, {double? min, double? max}) {
    double width = percentage / 100 * _width;
    return _numberWithinLimitation(width, min: min, max: max);
  }

  /// proportionate height with limitation
  static double proportionateHeightWithConstraints(double height, {double? min, double? max}) {
    double newHeight = proportionateHeight(height);
    return _numberWithinLimitation(newHeight, min: min, max: max);
  }

  /// proportionate width with limitation
  static double proportionateWidthWithConstraints(double width, {double? min, double? max}) {
    double newWidth = proportionateWidth(width);
    return _numberWithinLimitation(newWidth, min: min, max: max);
  }

  /// Page horizontal padding in smartphones
  static double get horizontalPadding => widthPercentageWithConstraints(5, max: 15);

  /// Page horizontal padding in tablet
  static double get tabletHorizontalPadding => widthPercentage(17.5);

  /// Get the required horizontal padding according to the device type
  static double get dynamicHorizontalPadding =>
      _isTablet ? tabletHorizontalPadding : horizontalPadding;

  /// Get the required drawer width according to the device type
  static double get dynamicDrawerWidth => _isTablet ? widthPercentage(50) : widthPercentage(90);
}
