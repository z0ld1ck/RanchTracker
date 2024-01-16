import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';
import 'package:malshy/features/auth/presentation/bloc/auth/auth_bloc.dart';

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
    final statusCode = response.statusCode ?? 0;
    final success = statusCode >= 200 && statusCode < 300;

    if (response.data is Map<String, dynamic> && response.data.containsKey('access')) {
      GetIt.I<KeyValueStorageService>().setAccessToken(response.data['access']);
    }

    if (response.data is Map<String, dynamic> && response.data.containsKey('refresh')) {
      GetIt.I<KeyValueStorageService>().setRefreshToken(response.data['refresh']);
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
        return handler.resolve(
          await retry(err.requestOptions),
        );
      } else {
        GetIt.I<KeyValueStorageService>().resetKeys();
        GetIt.I<AuthBloc>().add(AuthEvent.logOut());
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
    final response = await Dio().post(
      ApiEndpoint.baseUrl + AuthEndpoint.REFRESH_TOKEN.path,
      data: {'refresh': refreshToken},
    );
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      GetIt.I<KeyValueStorageService>().setAccessToken(response.data['access']);
      GetIt.I<KeyValueStorageService>().setRefreshToken(response.data['refresh']);
    } else {
      GetIt.I<KeyValueStorageService>().resetKeys();
      GetIt.I<AuthBloc>().add(AuthEvent.logOut());
    }
  }
}
