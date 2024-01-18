import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/domain/repositories/live_stock_repository.dart';

class CreateLivestockUsecase implements Usecase<DataState<LivestockModel>, LivestockModel> {
  final LiveStockRepository _liveStockRepository;

  CreateLivestockUsecase(this._liveStockRepository);

  @override
  Future<DataState<LivestockModel>> call({LivestockModel? params}) async {
    return await _liveStockRepository.createLivestock(params!);
  }
}
