part of 'network_client.dart';

/// typedef for Dio and Http parser data types

typedef DioFormData = FormData;
typedef DioOptions = Options;
typedef HttpMediaType = MediaType;
typedef DioFailure = DioException;

/// List of dio socket exception types
List<DioExceptionType> get dioSocketExceptions => [
      DioExceptionType.connectionError,
      DioExceptionType.connectionError,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
    ];
