import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

// sealed class Failure<T> {
//   final T? data;
//   final DioException? error;
//
//   Failure({this.data, this.error});
// }
//
// class DataFailed<T> extends Failure<T> {
//   DataFailed(DioException error) : super(error: error);
// }
//
// class DataSuccess<T> extends Failure<T> {
//   DataSuccess(T data) : super(data: data);
// }
