import 'package:dartz/dartz.dart';
import 'package:dio/src/dio_exception.dart';
import 'package:malshy/core/error/failures.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/network_client.dart';
import '../../domain/repositories/live_stock_repository.dart';
import '../models/livestock_model.dart';

class LiveStockRepositoryImpl implements LiveStockRepository {
  final NetworkClient _networkClient;

  LiveStockRepositoryImpl(this._networkClient);

  @override
  Future<Either<DataFailed, LivestockModel>> createLiveStock(
      LivestockModel livestock) async {
    try {
      final livestockData = await _networkClient.postData(
        endpoint: LivestockEndpoint.ADD_LIVESTOCK.toString(),
        body: livestock.toJson(),
        parser: (response) => LivestockModel.fromJson(response),
      );

      return Right(
          livestockData!); // Assuming livestockData is not null on success
    } catch (e) {
      // Use the appropriate error details for DataFailed
      final failure = e is DioError
          ? DataFailed(e.response?.statusCode as DioException)
          : DataFailed(
              500 as DioException,
            );
      return Left(failure);
    }
  }
}
