import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock/domain/repositories/live_stock_repository.dart';
import '../../data/models/livestock_model.dart';

class CreateLiveStockUseCase implements Usecase<DataState<LivestockModel>, Map<String, dynamic>> {
  final LiveStockRepository _liveStockRepository;

  CreateLiveStockUseCase(this._liveStockRepository);

  @override
  Future<DataState<LivestockModel>> call({Map<String, dynamic>? params}) async {
    return await _liveStockRepository.createLiveStock(
      LivestockModel(
          RFID: params?['RFID'],
          birthday: params?['birthday'],
          sex: params?['sex'],
          age: params?['age'],
          weight: params?['weight'],
          addition_method: params?['addition_method']),
    );
  }
}
