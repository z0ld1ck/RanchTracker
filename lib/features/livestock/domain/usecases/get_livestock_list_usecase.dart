import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/domain/repositories/live_stock_repository.dart';

class GetLivestockListUsecase implements Usecase<DataState<List<LivestockModel>>, Map<String, dynamic>> {
  final LiveStockRepository _liveStockRepository;

  GetLivestockListUsecase(this._liveStockRepository);

  @override
  Future<DataState<List<LivestockModel>>> call({Map<String, dynamic>? params}) async {
    return await _liveStockRepository.getLiveStock(queryParams: params!);
  }
}
