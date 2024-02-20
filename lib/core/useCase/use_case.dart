import '../resources/data_state.dart';

abstract class UseCase<T, P> {
  FutureData<T> call(P parameter);
}

abstract class UseCase2<T> {
  FutureData<T> call();
}
