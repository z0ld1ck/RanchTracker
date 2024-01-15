import 'package:malshy/core/usecase/usecase.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_breeds_model.dart';

import '../repositories/live_stock_repository.dart';

class GetTypesAndBreedsUseCase
    implements UseCase<DataState<TypeBreedsModel>, Map<String, dynamic>> {
  final LiveStockRepository liveStockRepository;

  GetTypesAndBreedsUseCase(this.liveStockRepository);

  @override
  Future<DataState<TypeBreedsModel>> call(Map<String, dynamic>? params) async {
    return await liveStockRepository.getTypesAndBreeds(
      TypeBreedsModel(
        name: params?['name'],
        type: params?['type'],
        breeds: params?['breeds'],
      ),
    );
  }
}
