import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor() : super();
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey('requiresAuthToken')) {
      if (options.extra['requiresAuthToken'] == true) {
        final token = await GetIt.I<KeyValueStorageService>().getAccessToken();
        options.headers.addAll(
          <String, Object?>{'Authorization': '$token'},
        );
      }

      options.extra.remove('requiresAuthToken');
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final success = response.statusCode == 200 || response.statusCode == 201;

    if (response.headers.value('Authorization') != null) {
      GetIt.I<KeyValueStorageService>().setAccessToken(response.headers.value('Authorization')!);
    }
    if (success) return handler.next(response);


    return handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
      ),
    );
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await GetIt.I<KeyValueStorageService>().getRefreshToken();
      if (refreshToken != null) {
        await _refreshToken(refreshToken: refreshToken);
        return handler.resolve(await retry(err.requestOptions));
      }
    }
    return handler.next(err);
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return Dio().request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> _refreshToken({required String refreshToken}) async {
    //TODO: refresh token
    final response = await Dio().post(
      '',
      data: {'refreshToken': refreshToken},
    );
    if (response.statusCode == 201) {
      GetIt.I<KeyValueStorageService>().setAccessToken(response.data['accessToken']);
      //TODO: update refreshToken?
    } else {
      GetIt.I<KeyValueStorageService>().resetKeys();
    }
  }
}
