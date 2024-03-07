typedef FutureData<T> = Future<DataState<T>>;
typedef FutureList<T> = Future<DataState<List<T>>>;
typedef FutureBool = Future<DataState<bool>>;

abstract class DataState<T> {
  final T? data;
  final ErrorData? error;

  const DataState({this.data, this.error});
}

class DataSuccessSate<T> extends DataState<T> {
  const DataSuccessSate({required T data}) : super(data: data);
}

class DataFailureSate<T> extends DataState<T> {
  const DataFailureSate({ErrorData error = const ErrorData()}) : super(error: error);
}

class NetworkFailureSate<T> extends DataState<T> {
  const NetworkFailureSate({
    super.error = const ErrorData(
      error: "Network Connection Error",
      message: "Network connection failed",
      type: ErrorType.noNetwork,
    ),
  });
}

class ErrorData {
  final String error;
  final String message;
  final ErrorType type;

  const ErrorData({
    this.error = "Operation failed",
    this.message = "Error occurred",
    this.type = ErrorType.unknown,
  });
}

enum ErrorType {
  unknown,
  typeError,
  formatException,
  dioException,
  isarException,
  noNetwork,
  socketTimeOut,
  invalidUserCredential,
  tokenExpired,
  badRequest,
  server,
}
