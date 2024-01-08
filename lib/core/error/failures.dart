import 'package:dio/dio.dart';

abstract class Failure<T> {
  final T? data;
  final DioException? error;

  const Failure({this.data, this.error});
}

class DataSuccess<T> extends Failure<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends Failure<T> {
  const DataFailed(DioException error) : super(error: error);
}
