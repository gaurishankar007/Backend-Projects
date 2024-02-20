import '../../injection/injector.dart';

extension DoubleExtension on double {
  double get hPercentage => screenSize.heightPercentage(this);
  double get wPercentage => screenSize.widthPercentage(this);
}
