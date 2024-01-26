import '../resources/data_state.dart';

abstract class UCP<T, P> {
  FDState<T> call(P param);
}
