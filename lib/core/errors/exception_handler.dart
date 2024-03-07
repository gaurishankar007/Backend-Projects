import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:isar/isar.dart';

import '../resources/data_state.dart';

FutureData<T> exceptionHandler<T>(Future Function() callBack, {ErrorData? errorData}) async {
  try {
    return await callBack();
  } on DioException catch (error) {
    debugPrint(error.toString());
    // debugPrint(error.response.toString());

    bool socketException = [
      DioExceptionType.connectionError,
      DioExceptionType.connectionError,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
    ].contains(error.type);

    if (socketException) return NetworkFailureSate<T>();

    final errorData = ErrorData(
      error: error.toString(),
      message: "Server request failed",
      type: ErrorType.dioException,
    );
    return DataFailureSate<T>(error: errorData);
  } on IsarError catch (error) {
    debugPrint(error.toString());
    final errorData = ErrorData(
      error: error.toString(),
      message: "Local database error",
      type: ErrorType.isarException,
    );
    return DataFailureSate<T>(error: errorData);
  } on TypeError catch (error) {
    debugPrint(error.toString());
    final errorData = ErrorData(
      error: error.toString(),
      message: "Unsupported data type is assigned",
      type: ErrorType.typeError,
    );
    return DataFailureSate<T>(error: errorData);
  } on FormatException catch (error) {
    debugPrint(error.toString());
    final errorData = ErrorData(
      error: error.toString(),
      message: "Operation on unsupported data format",
      type: ErrorType.formatException,
    );
    return DataFailureSate<T>(error: errorData);
  } catch (error) {
    debugPrint(error.toString());
    return DataFailureSate<T>(error: errorData ?? ErrorData(error: error.toString()));
  }
}
