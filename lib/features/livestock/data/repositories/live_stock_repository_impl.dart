import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/network/network_client.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';

import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import '../../domain/repositories/live_stock_repository.dart';

class LiveStockRepositoryImpl implements LiveStockRepository {
  final NetworkClient _networkClient = GetIt.I.get<NetworkClient>();

  LiveStockRepositoryImpl();

  @override
  Future<DataState<LivestockModel>> createLiveStock(LivestockModel livestockModel) async {
    try {
      final newLivestockModel = await _networkClient.postData<LivestockModel>(
        endpoint: LivestockEndpoint.ADD_LIVESTOCK.path,
        body: FormData.fromMap(await livestockModel.toApiJson()),
        parser: (response) => LivestockModel.fromJson(response),
      );
      if (newLivestockModel != null)
        return DataSuccess(livestockModel);
      else
        return DataFailed(CustomException(message: 'bad response'));
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<LivestockModel>>> getLiveStock({required Map<String, dynamic> queryParams}) async {
    try {
      final livestockList = await _networkClient.getData<List<LivestockModel>>(
        endpoint: LivestockEndpoint.GET_LIVESTOCK_LIST.path,
        queryParams: queryParams,
        parser: (Map<String, dynamic> data) {
          return livestockModelListFromJson(jsonEncode(data['results']));
        },
      );
      return DataSuccess(livestockList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<AdditionTypeModel>>> getAdditionType() async {
    try {
      final additionTypesList = await _networkClient.getListData(
        endpoint: LivestockEndpoint.GET_ADDITION_TYPE.path,
        parser: (List<dynamic> data) {
          return additionTypeModelFromJson(jsonEncode(data));
        },
      );

      return DataSuccess(additionTypesList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TypeModel>>> getTypesAndBreeds() async {
    try {
      final typesList = await _networkClient.getListData<TypeModel>(
        endpoint: LivestockEndpoint.TYPES_BREEDS.path,
        parser: (List<dynamic> data) {
          return typeFromJson(jsonEncode(data));
        },
      );
      return DataSuccess(typesList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
