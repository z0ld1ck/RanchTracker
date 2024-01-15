import 'package:malshy/core/usecase/usecase.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock_list_page/domain/repositories/live_stock_repository.dart';

class GetLivestockListUsecase implements UseCase<DataState<List<GetLivestockModel>>, Map<String, dynamic>> {
  final LiveStockRepository _liveStockRepository;

  GetLivestockListUsecase(this._liveStockRepository);

  @override
  Future<DataState<List<GetLivestockModel>>> call(Map<String, dynamic>? params) async {
    return await _liveStockRepository.getLiveStock(queryParams: params!);
  }
}