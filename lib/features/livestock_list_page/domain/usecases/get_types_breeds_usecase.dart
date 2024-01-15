import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/core/utils/usecase.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_model.dart';
import 'package:malshy/features/livestock_list_page/domain/repositories/live_stock_repository.dart';

class GetTypesAndBreedsUsecase implements Usecase<DataState<List<TypeModel>>, void> {
  final LiveStockRepository _liveStockRepository;

  GetTypesAndBreedsUsecase(this._liveStockRepository);

  @override
  Future<DataState<List<TypeModel>>> call({void params}) async {
    return await _liveStockRepository.getTypesAndBreeds();
  }
}
