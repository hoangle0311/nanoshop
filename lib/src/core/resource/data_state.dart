import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;

  const DataState({
    this.data,
    this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({
    required T data,
  }) : super(
          data: data,
          error: null,
        );
}

class DataFailed<T> extends DataState<T> {
  const DataFailed({
    required DioError error,
  }) : super(
          data: null,
          error: error,
        );
}
