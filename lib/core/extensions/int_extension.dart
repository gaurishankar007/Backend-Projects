import '../../injection/injector.dart';

extension IntegerExtension on int {
  double get pH => sCon.pHeight(toDouble());
  double get pW => sCon.pWidth(toDouble());
}
