import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/dashboard/data/models/dashboard_by_status_model.dart';
import 'package:malshy/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardByStatusUsecase implements Usecase<DataState<List<DashboardByStatusModel>>, void> {
  final DashboardRepository _dashboardRepository;

  GetDashboardByStatusUsecase(this._dashboardRepository);

  @override
  Future<DataState<List<DashboardByStatusModel>>> call({void params}) async {
    return await _dashboardRepository.getDashboardByStatus();
  }
}
