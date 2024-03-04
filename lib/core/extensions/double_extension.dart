import '../../injection/injector.dart';

extension DoubleExtension on double {
  double get propHeight => screenSize.proportionateHeight(this);
  double get propWidth => screenSize.proportionateWidth(this);
  double get hPercentage => screenSize.heightPercentage(this);
  double get wPercentage => screenSize.widthPercentage(this);

  double hPConstraint({double? min, double? max}) =>
      screenSize.heightPercentageWithConstraints(this, min: min, max: max);
  double wPConstraint({double? min, double? max}) =>
      screenSize.widthPercentageWithConstraints(this, min: min, max: max);
  double pHConstraint({double? min, double? max}) =>
      screenSize.proportionateHeightWithConstraints(this, min: min, max: max);
  double pWConstraint({double? min, double? max}) =>
      screenSize.proportionateWidthWithConstraints(this, min: min, max: max);
}
