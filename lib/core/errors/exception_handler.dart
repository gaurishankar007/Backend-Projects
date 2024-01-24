import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../resources/data_state.dart';

Future<DataState<T>> exceptionHandler<T>(
  Future Function() cb, {
  DError? error,
}) async {
  try {
    return await cb();
  } on DioException catch (error) {
    bool socketException = error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout;

    if (socketException) return const NetworkFailureState();

    debugPrint(error.toString());
    // debugPrint(error.response.toString());

    return FailureState(
      error: DError(
        error: error.toString(),
        message: "Server request failed",
        type: ErrorType.dioException,
      ),
    );
  } catch (er) {
    debugPrint(error.toString());
    return FailureState(error: error ?? DError(error: er.toString()));
  }
}
