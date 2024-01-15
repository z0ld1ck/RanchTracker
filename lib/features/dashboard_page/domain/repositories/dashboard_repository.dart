import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_action_model.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_status_model.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_type_model.dart';

abstract class DashboardRepository {
  Future<DataState<List<DashboardByStatusModel>>> getDashboardByStatus();

  Future<DataState<List<DashboardByTypeModel>>> getDashboardByType();

  Future<DataState<DashboardByActionModel>> getDashboardByAction();
}
