import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:malshy/core/network/api_endpoints.dart';
import 'package:malshy/core/network/custom_exceptions.dart';
import 'package:malshy/core/network/network_client.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_action_model.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_status_model.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_type_model.dart';
import 'package:malshy/features/dashboard_page/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final NetworkClient _networkClient = GetIt.I.get<NetworkClient>();

  @override
  Future<DataState<List<DashboardByTypeModel>>> getDashboardByType() async {
    try {
      final dashboardByTypeList = await _networkClient.getListData<DashboardByTypeModel>(
        endpoint: DashboardEndpoint.LIVESTOCK_BY_TYPE.path,
        parser: (List<dynamic> data) {
          return dashboardByTypeModelFromJson(jsonEncode(data));
        },
      );
      return DataSuccess(dashboardByTypeList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<DashboardByStatusModel>>> getDashboardByStatus() async {
    try {
      final dashboardByStatusList = await _networkClient.getListData<DashboardByStatusModel>(
        endpoint: DashboardEndpoint.LIVESTOCK_BY_STATUS.path,
        parser: (List<dynamic> data) {
          return dashboardByStatusModelFromJson(jsonEncode(data));
        },
      );
      return DataSuccess(dashboardByStatusList);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DashboardByActionModel>> getDashboardByAction() async {
    try {
      final dashboardByAction = await _networkClient.getData<DashboardByActionModel>(
        endpoint: DashboardEndpoint.LIVESTOCK_BY_ACTION.path,
        parser: (Map<String, dynamic> data) {
          return DashboardByActionModel.fromJson(data);
        },
      );
      return DataSuccess(dashboardByAction);
    } on CustomException catch (e) {
      return DataFailed(e);
    }
  }
}
