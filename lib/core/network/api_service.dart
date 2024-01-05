import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:malshy/core/network/custom_exceptions.dart';

// Services
import './api_interface.dart';
import './dio_service.dart';

// Models
import 'response_model.dart';

class ApiService implements ApiInterface {
  late final DioService _dioService;
  ApiService(DioService dioService) : _dioService = dioService;

  @override
  Future<T> getDocumentData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) parser,
  }) async {
    Map<String, dynamic> data;
    try {
      final response = await _dioService.get<Map<String, dynamic>>(
        endpoint: endpoint,
        queryParams: queryParams,
        cacheOptions: _dioService.globalCacheOptions?.copyWith(
          policy: cachePolicy,
          maxStale: cacheAgeDays != null ? Nullable(Duration(days: cacheAgeDays)) : null,
        ),
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        data = response.data!;
      } else {
        throw CustomException.fromDioException(
          Exception('Response data is null'),
        );
      }
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return parser(data);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> getListData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiresAuthToken = true,
    required T Function(List<dynamic>) parser,
  }) async {
    List<dynamic> data;
    try {
      final response = await _dioService.get<List<dynamic>>(
        endpoint: endpoint,
        queryParams: queryParams,
        cacheOptions: _dioService.globalCacheOptions?.copyWith(
          policy: cachePolicy,
          maxStale: cacheAgeDays != null ? Nullable(Duration(days: cacheAgeDays)) : null,
        ),
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.data != null) {
        data = response.data!;
      } else {
        throw CustomException.fromDioException(
          Exception('Response data is null'),
        );
      }
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return parser(data);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T?> postData<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response)? parser,
  }) async {
    Map<String, dynamic> data = {};

    try {
      final response = await _dioService.post(
        endpoint: endpoint,
        data: body,
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
      if (response.data == null && parser == null) {
        return null;
      } else if (response.data == null && parser != null) {
        throw CustomException.fromDioException(
          Exception('Response data is null'),
        );
      } else {
        data = {...response.data!};
      }
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      return parser != null ? parser(data) : null;
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> updateData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) parser,
  }) async {
    ResponseModel<Map<String, dynamic>> response;

    try {
      // Entire map of response
      response = await _dioService.patch<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return parser(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  Future<T> deleteData<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) parser,
  }) async {
    ResponseModel<Map<String, dynamic>> response;

    try {
      // Entire map of response
      response = await _dioService.delete<Map<String, dynamic>>(
        endpoint: endpoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );
    } on Exception catch (ex) {
      throw CustomException.fromDioException(ex);
    }

    try {
      // Returning the serialized object
      return parser(response);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _dioService.cancelRequests(cancelToken: cancelToken);
  }
}
