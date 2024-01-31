import 'package:flutter/material.dart' show debugPrint;
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../resources/data_state.dart';

FDState<T> exceptionHandler<T>(
  Future Function() cb, {
  DError? error,
}) async {
  try {
    return await cb();
  } on DioException catch (error) {
    debugPrint(error.toString());
    // debugPrint(error.response.toString());

    bool socketException = error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout;

    if (socketException) return NetworkFailureState<T>();

    return FailureState<T>(
      error: DError(
        error: error.toString(),
        message: "Server request failed",
        type: ErrorType.dioException,
      ),
    );
  } on IsarError catch (er) {
    debugPrint(er.toString());
    final err = error ?? DError(error: er.toString(), type: ErrorType.isarException);
    return FailureState<T>(error: err);
  } on FormatException catch (er) {
    debugPrint(er.toString());
    final err = error ?? DError(error: er.toString(), type: ErrorType.formatException);
    return FailureState<T>(error: err);
  } catch (er) {
    debugPrint(er.toString());
    return FailureState<T>(error: error ?? DError(error: er.toString()));
  }
}
