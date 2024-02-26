import '../../injection/injector.dart';

extension IntegerExtension on int {
  double get propHeight => screenSize.proportionateHeight(toDouble());
  double get propWidth => screenSize.proportionateWidth(toDouble());
  double get hPercentage => screenSize.heightPercentage(toDouble());
  double get wPercentage => screenSize.widthPercentage(toDouble());

  double pHConstraint({double? min,double? max}) =>
      screenSize.proportionateHeightWithConstraints(toDouble(), min: min, max: max);

  double pWConstraint({double? min,double? max}) =>
      screenSize.proportionateWidthWithConstraints(toDouble(), min: min, max: max);
}
