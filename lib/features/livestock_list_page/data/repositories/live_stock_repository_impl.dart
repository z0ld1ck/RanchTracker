import 'dart:convert';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/network/network_client.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/addition_type_model.dart';

import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_model.dart';
import '../../domain/repositories/live_stock_repository.dart';
import '../models/livestock_model.dart';

class LiveStockRepositoryImpl implements LiveStockRepository {
  final NetworkClient _networkClient = GetIt.I.get<NetworkClient>();

  LiveStockRepositoryImpl();

  @override
  Future<DataState<LivestockModel>> createLiveStock(LivestockModel livestockModel) async {
    try {
      Response response = (
        await _networkClient.postData(
          endpoint: LivestockEndpoint.ADD_LIVESTOCK.path,
          body: {
            'RFID': livestockModel.RFID,
            'birthday': livestockModel.birthday,
            'sex': livestockModel.sex,
            'age': livestockModel.age,
            'weight': livestockModel.weight,
            'nickname': livestockModel.nickname,
            'addition_method': livestockModel.addition_method,
            'RFIDm': livestockModel.RFIDm,
            'RFIDf': livestockModel.RFIDf,
            'farm_id': livestockModel.farm_id,
          },
          parser: (response) => LivestockModel.fromJson(response),
        ),
      ) as Response;

      if (response.statusCode == HttpStatus.created) {
        LivestockModel livestockModel = LivestockModel.fromJson(
          jsonDecode(response.body),
        );
        print(response.body);
        return DataSuccess(livestockModel);
      } else {
        return DataFailed(CustomException(message: 'bad response'));
      }
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
     
  @override
  Future<DataState<List<GetLivestockModel>>> getLiveStock({required Map<String, dynamic> queryParams}) async {
    try {
      final livestockList = await _networkClient.getData<List<GetLivestockModel>>(
        endpoint: LivestockEndpoint.GET_LIVESTOCK_LIST.path,
        queryParams: queryParams,
        parser: (Map<String, dynamic> data) {
          return getLivestockModelFromJson(jsonEncode(data['results']));
        },
      );
      return DataSuccess(livestockList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<AdditionTypeModel>> getAdditionType(
      AdditionTypeModel additionTypeModel) async {
    try {
      final List<Map<String, dynamic>> queryParams = [
        {
          "name": {
            "ru": "Родился в хозяйстве",
            "kz": "Шаруашылықта дүниеге келген",
            "en": "Was born on the farm"
          },
          "type": 1
        },
        {
          "name": {"ru": "Купленный", "kz": "Сатып алынған", "en": "Bought"},
          "type": 2
        },
      ];

      final response = await _networkClient.getData(
        endpoint: LivestockEndpoint.GET_ADDITION_TYPE.path,
        queryParams: {'types': queryParams},
        parser: (response) => AdditionTypeModel.fromJson(response),
      );

      return DataSuccess(response);
    } on CustomException catch (e) {
      return DataFailed(e);
    } catch (e) {
      return DataFailed(
        CustomException(message: 'Unexpected error occurred.'),
      );
    }
  }
      
  @override
  Future<DataState<List<TypeModel>>> getTypesAndBreeds() async {
    try {
      final livestockList = await _networkClient.getListData<TypeModel>(
        endpoint: LivestockEndpoint.TYPES_BREEDS.path,
        parser: (List<dynamic> data) {
          return typeFromJson(jsonEncode(data));
        },
      );
      return DataSuccess(livestockList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
