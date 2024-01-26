typedef FDState<T> = Future<DataState<T>>;

abstract class DataState<T> {
  final T? data;
  final DError? error;

  const DataState({this.data, this.error});
}

class SuccessState<T> extends DataState<T> {
  const SuccessState({required T data}) : super(data: data);
}

class FailureState<T> extends DataState<T> {
  const FailureState({required DError error}) : super(error: error);
}

class NetworkFailureState<T> extends DataState<T> {
  const NetworkFailureState({
    super.error = const DError(
      error: "Network Connection Error",
      message: "Network connection failed",
      type: ErrorType.noNetwork,
    ),
  });
}

class DError {
  final String error;
  final String message;
  final ErrorType type;

  const DError({
    required this.error,
    this.message = "Error Occurred",
    this.type = ErrorType.unknown,
  });
}

enum ErrorType {
  unknown,
  dioException,
  isarException,
  noNetwork,
  socketTimeOut,
  tokenExpired,
  invalidUserCredential,
  server,
  badRequest,
}
