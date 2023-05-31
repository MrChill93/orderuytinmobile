// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../app_logger.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;
  bool ok = false;
  String responseCode = "";

  final HttpResponse<T>? originResponse;

  DataState({
    this.data,
    this.error,
    this.originResponse,
  });
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required T data,
    required HttpResponse<T>? originResponse,
  }) : super(
          data: data,
          error: null,
          originResponse: originResponse,
        ) {
    if (data != null) {
      try {
        // Todo: Implement Custom parsing data!
      } catch (e) {
        AppLogger.shared.logErr("DataState", e);
      }
    }
  }
}

class DataFailed<T> extends DataState<T> {
  DataFailed({
    DioError? dioError,
    HttpResponse<T>? originResponse,
    T? data,
  }) : super(
          data: data,
          error: dioError,
          originResponse: originResponse,
        ) {
    if (data != null) {
      try {
        // Todo: Implement Custom parsing data!
      } catch (e) {
        AppLogger.shared.logErr("DataState", e);
      }
    }
  }
}
