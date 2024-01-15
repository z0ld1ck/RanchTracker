import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/dashboard_page/data/models/dashboard_by_type_model.dart';
import 'package:malshy/features/dashboard_page/domain/repositories/dashboard_repository.dart';

class GetDashboardByTypeUsecase implements Usecase<DataState<List<DashboardByTypeModel>>, void> {
  final DashboardRepository _dashboardRepository;

  GetDashboardByTypeUsecase(this._dashboardRepository);

  @override
  Future<DataState<List<DashboardByTypeModel>>> call({void params}) async {
    return await _dashboardRepository.getDashboardByType();
  }
}
