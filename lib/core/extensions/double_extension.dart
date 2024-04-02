import '../utils/screen.dart';

extension DoubleExtension on double {
  /// Required percentage of height according the screen height
  double get hPercentage => Screen.heightPercentage(toDouble());

  /// Required percentage of width according the screen width
  double get wPercentage => Screen.widthPercentage(toDouble());

  /// proportionate height of the screen according the height of the Design (Figma)
  double get propHeight => Screen.proportionateHeight(toDouble());

  /// proportionate width of the screen according the width of the Design (Figma)
  double get propWidth => Screen.proportionateWidth(toDouble());

  /// Required percentage of height with limitation
  double hPConstraint({double? min, double? max}) =>
      Screen.heightPercentageWithConstraints(toDouble(), min: min, max: max);

  /// Required percentage of width with limitation
  double wPConstraint({double? min, double? max}) =>
      Screen.widthPercentageWithConstraints(toDouble(), min: min, max: max);

  /// proportionate height with limitation
  double pHConstraint({double? min, double? max}) =>
      Screen.proportionateHeightWithConstraints(toDouble(), min: min, max: max);

  /// proportionate width with limitation
  double pWConstraint({double? min, double? max}) =>
      Screen.proportionateWidthWithConstraints(toDouble(), min: min, max: max);
}
