import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/domain/repositories/live_stock_repository.dart';
import 'package:tuple/tuple.dart';

class EditLivestockUsecase implements Usecase<DataState<LivestockModel>, Tuple2<LivestockModel, List<int>>> {
  final LiveStockRepository _liveStockRepository;

  EditLivestockUsecase(this._liveStockRepository);

  @override
  Future<DataState<LivestockModel>> call({Tuple2<LivestockModel, List<int>>? params}) async {
    return await _liveStockRepository.editLivestock(params!.item1, params.item2);
  }
}
