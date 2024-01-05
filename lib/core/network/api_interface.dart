import 'package:dio/dio.dart';

// Models
import 'response_model.dart';

/// A base class containing methods for basic API functionality.
///
/// Should be implemented by any service class that wishes to interact
/// with an API.
abstract class ApiInterface {
  /// Abstract const constructor. This constructor enables subclasses
  /// to provide const constructors so that they can be used in
  /// const expressions.
  const ApiInterface();

  /// Base method for requesting a document of data from the [endpoint].
  ///
  /// The response is deserialized into a single model objects of type [T],
  /// using the [parser] callback.
  ///
  /// [queryParams] holds any query parameters for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> getDocumentData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> responseBody) parser,
  });

  Future<T> getListData<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(List<dynamic> responseBody) parser,
  });

  /// Base method for inserting [body] at the [endpoint].
  ///
  /// The [body] contains body for the request.
  ///
  /// The response is deserialized into an object of type [T],
  /// using the [parser] callback.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T?> postData<T>({
    required String endpoint,
    required Map<String, dynamic> body,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(Map<String, dynamic> response) parser,
  });

  /// Base method for updating [data] at the [endpoint].
  ///
  /// The response is deserialized into an object of type [T],
  /// using the [parser] callback.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> updateData<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) parser,
  });

  /// Base method for deleting [data] at the [endpoint].
  ///
  /// The response is deserialized into an object of type [T],
  /// using the [parser] callback.
  ///
  /// The [data] contains body for the request.
  ///
  /// [cancelToken] is used to cancel the request pre-maturely. If null,
  /// the **default** [cancelToken] inside [DioService] is used.
  ///
  /// [requiresAuthToken] is used to decide if a token will be inserted
  /// in the **headers** of the request using an [ApiInterceptor]
  Future<T> deleteData<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
    required T Function(ResponseModel<Map<String, dynamic>> response) parser,
  });

  /// Base method for cancelling requests pre-maturely
  /// using the [cancelToken].
  ///
  /// If null, the **default** [cancelToken] inside [DioService] is used.
  void cancelRequests({CancelToken? cancelToken});
}
