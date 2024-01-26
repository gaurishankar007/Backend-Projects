import '../resources/data_state.dart';

abstract class UC<T> {
  FDState<T> call();
}
