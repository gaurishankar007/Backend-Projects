import '../../injection/injector.dart';

extension IntegerExtension on int {
  double get pHeight => screenSize.proportionateHeight(toDouble());
  double get pWidth => screenSize.proportionateWidth(toDouble());
  double get hPercentage => screenSize.heightPercentage(toDouble());
  double get wPercentage => screenSize.widthPercentage(toDouble());

  double pHConstraint({double? min, max}) =>
      screenSize.proportionateHeightWithConstraints(toDouble(), min: min, max: max);

  double pWConstraint({double? min, max}) =>
      screenSize.proportionateWidthWithConstraints(toDouble(), min: min, max: max);
}
