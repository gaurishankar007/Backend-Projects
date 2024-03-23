import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

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

/// Dio request data
class RequestForm {
  final String path;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final CancelToken? cancelToken;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;

  const RequestForm(
    this.path, {
    this.data,
    this.queryParameters,
    this.options,
    this.cancelToken,
    this.onSendProgress,
    this.onReceiveProgress,
  });

  @override
  bool operator ==(covariant RequestForm other) {
    bool equal = other.path == path;
    if (other.data == null && data == null) return equal;

    bool dataEquality = const DeepCollectionEquality.unordered().equals(other.data, data);
    return dataEquality && equal;
  }

  @override
  int get hashCode => Object.hash(path, data);
}

class MultiPartForm {
  final String filePath;
  final String? filename;
  final MediaType? contentType;
  final Map<String, List<String>>? headers;

  const MultiPartForm(
    this.filePath, {
    this.filename,
    this.contentType,
    this.headers,
  });

  @override
  bool operator ==(covariant MultiPartForm other) => other.filePath == filePath;

  @override
  int get hashCode => filePath.hashCode;
}

/// Convenience methods to make an HTTP PATCH request.
abstract class NetworkService {
  Future<Response<T>> get<T>(RequestForm form);
  Future<Response<T>> post<T>(RequestForm form);
  Future<Response<T>> put<T>(RequestForm form);
  Future<Response<T>> patch<T>(RequestForm form);
  Future<Response<T>> delete<T>(RequestForm form);
  Future<MultipartFile> multipartFormFile<T>(MultiPartForm form);
}

class NetworkServiceImplementation implements NetworkService {
  final Dio dio;

  NetworkServiceImplementation({required this.dio});

  @override
  Future<Response<T>> get<T>(RequestForm form) async => await dio.get(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> post<T>(RequestForm form) async => await dio.post(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onSendProgress: form.onSendProgress,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> put<T>(RequestForm form) async => await dio.put(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onSendProgress: form.onSendProgress,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> patch<T>(RequestForm form) async => await dio.put(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onSendProgress: form.onSendProgress,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> delete<T>(RequestForm form) async => await dio.delete(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
      );

  @override
  Future<MultipartFile> multipartFormFile<T>(MultiPartForm form) async =>
      await MultipartFile.fromFile(
        form.filePath,
        filename: form.filename,
        contentType: form.contentType,
        headers: form.headers,
      );
}
