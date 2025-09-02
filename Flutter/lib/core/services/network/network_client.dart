import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

part 'multi_part_client.dart';
part 'network_data_types.dart';
part 'network_forms.dart';

/// Convenience methods to make an HTTP PATCH request.
abstract class NetworkClient {
  Future<Response<T>> get<T>(RequestForm form);
  Future<Response<T>> post<T>(RequestForm form);
  Future<Response<T>> put<T>(RequestForm form);
  Future<Response<T>> patch<T>(RequestForm form);
  Future<Response<T>> delete<T>(RequestForm form);
}

class NetworkClientImplementation implements NetworkClient {
  final Dio _dio;

  NetworkClientImplementation({required Dio dio}) : _dio = dio;

  @override
  Future<Response<T>> get<T>(RequestForm form) async => await _dio.get(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> post<T>(RequestForm form) async => await _dio.post(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onSendProgress: form.onSendProgress,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> put<T>(RequestForm form) async => await _dio.put(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onSendProgress: form.onSendProgress,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> patch<T>(RequestForm form) async => await _dio.put(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
        onSendProgress: form.onSendProgress,
        onReceiveProgress: form.onReceiveProgress,
      );

  @override
  Future<Response<T>> delete<T>(RequestForm form) async => await _dio.delete(
        form.path,
        data: form.data,
        queryParameters: form.queryParameters,
        options: form.options,
        cancelToken: form.cancelToken,
      );
}
