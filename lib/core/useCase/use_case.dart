import '../resources/data_state.dart';

abstract class UseCase<T, P> {
  FutureData<T> call(P parameter);
}

abstract class UseCaseWithoutParameter<T> {
  FutureData<T> call();
}
