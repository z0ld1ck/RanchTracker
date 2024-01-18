import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';

import '../repositories/live_stock_repository.dart';

class GetAdditionTypeUseCase implements Usecase<DataState<List<AdditionTypeModel>>, Map<String, dynamic>> {
  final LiveStockRepository liveStockRepository;

  GetAdditionTypeUseCase(this.liveStockRepository);

  @override
  Future<DataState<List<AdditionTypeModel>>> call({Map<String, dynamic>? params}) async {
    return await liveStockRepository.getAdditionType();
  }
}
