import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock/domain/repositories/live_stock_repository.dart';

class CreateLiveStockUseCase implements Usecase<DataState<LivestockModel>, LivestockModel> {
  final LiveStockRepository _liveStockRepository;

  CreateLiveStockUseCase(this._liveStockRepository);

  @override
  Future<DataState<LivestockModel>> call({LivestockModel? params}) async {
    return await _liveStockRepository.createLiveStock(params!);
    //   LivestockModel(
    //       RFID: params?['RFID'],
    //       birthday: params?['birthday'],
    //       sex: params?['sex'],
    //       age: params?['age'],
    //       weight: params?['weight'],
    //       addition_method: params?['addition_method']),
    // );
  }
}
