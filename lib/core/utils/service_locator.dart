import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/http_client.dart';
import 'package:malshy/core/network/dio_service.dart';
import 'package:malshy/core/network/interceptors/api_interceptor.dart';
import 'package:malshy/core/utils/key_value_storage_base.dart';
import 'package:malshy/core/utils/key_value_storage_service.dart';

Future<void> setupKeyValueStorageService() async {
  await KeyValueStorageBase.init();

  GetIt.I.registerSingleton<KeyValueStorageService>(KeyValueStorageService());
}

void setupApiService() {
  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.noCache, // Bcz we force cache on-demand in repositories
    maxStale: const Duration(days: 30), // No of days cache is valid
    keyBuilder: (options) => options.path,
  );
  final dioService = DioService(
    dioClient: Dio(
      BaseOptions(
        baseUrl: ApiEndpoint.baseUrl,
      ),
    ),
    interceptors: [
      ApiInterceptor(),
      DioCacheInterceptor(options: cacheOptions),
    ],
  );

  GetIt.I.registerSingleton<HttpClient>(HttpClient(dioService));
}