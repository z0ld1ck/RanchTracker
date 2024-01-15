import 'package:malshy/core/usecase/usecase.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_breeds_model.dart';

import '../repositories/live_stock_repository.dart';

class GetAdditionTypeUseCase
    implements UseCase<DataState<AdditionTypeModel>, Map<String, dynamic>> {
  final LiveStockRepository liveStockRepository;

  GetAdditionTypeUseCase(this.liveStockRepository);

  @override
  Future<DataState<AdditionTypeModel>> call(Map<String, dynamic>? params) async {
    return await liveStockRepository.getAdditionType(
      AdditionTypeModel(
        name: params?['name'],
        type: params?['type'],
      ),
    );
  }
}
