import 'dart:convert';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/network/network_client.dart';
import 'package:malshy/core/utils/data_state.dart';
import '../../domain/repositories/live_stock_repository.dart';
import '../models/livestock_model.dart';

class LiveStockRepositoryImpl implements LiveStockRepository {
  final NetworkClient _networkClient = GetIt.I.get<NetworkClient>();
  @override
  Future<DataState<LivestockModel>> createLiveStock(
      LivestockModel livestockModel) async {
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
        return DataFailed(
            CustomException(message: 'bad response'));
      }
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
