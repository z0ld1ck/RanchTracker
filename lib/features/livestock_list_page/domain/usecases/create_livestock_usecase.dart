import 'package:malshy/core/error/data_state.dart';
import 'package:malshy/core/usecase/usecase.dart';
import 'package:malshy/features/livestock_list_page/data/repositories/live_stock_repository_impl.dart';
import '../../data/models/livestock_model.dart';

class CreateLiveStockUseCase
    implements UseCase<DataState<LivestockModel>, Map<String, dynamic>> {
  final LiveStockRepositoryImpl _liveStockRepositoryImpl;

  CreateLiveStockUseCase(this._liveStockRepositoryImpl);

  @override
  Future<DataState<LivestockModel>> call(Map<String, dynamic>? params) async {
    return await _liveStockRepositoryImpl.createLiveStock(
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
