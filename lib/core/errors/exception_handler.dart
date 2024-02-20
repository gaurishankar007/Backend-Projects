import 'package:flutter/material.dart' show debugPrint;
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../resources/data_state.dart';

FutureData<T> exceptionHandler<T>(Future Function() callBack) async {
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
    final errorString = error.toString();
    debugPrint(errorString);
    return DataFailureSate<T>(error: ErrorData(error: errorString, type: ErrorType.isarException));
  } on FormatException catch (error) {
    final errorString = error.toString();
    debugPrint(errorString);
    return DataFailureSate<T>(
        error: ErrorData(error: errorString, type: ErrorType.formatException));
  } catch (error) {
    final errorString = error.toString();
    debugPrint(errorString);
    return DataFailureSate<T>(error: ErrorData(error: errorString));
  }
}
