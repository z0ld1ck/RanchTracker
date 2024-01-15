import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_action_model.dart';
import 'package:malshy/features/dashboard_page/domain/repositories/dashboard_repository.dart';

class GetDashboardByActionUsecase implements Usecase<DataState<DashboardByActionModel>, void> {
  final DashboardRepository _dashboardRepository;

  GetDashboardByActionUsecase(this._dashboardRepository);

  @override
  Future<DataState<DashboardByActionModel>> call({void params}) async {
    return await _dashboardRepository.getDashboardByAction();
  }
}
