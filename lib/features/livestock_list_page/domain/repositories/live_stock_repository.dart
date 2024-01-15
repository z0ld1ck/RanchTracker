import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_breeds_model.dart';
import '../../data/models/livestock_model.dart';

abstract class LiveStockRepository {
  Future<DataState<LivestockModel>> createLiveStock(
      LivestockModel livestockModel);

  Future<DataState<TypeBreedsModel>> getTypesAndBreeds(TypeBreedsModel typeBreedsModel);
  Future<DataState<AdditionTypeModel>> getAdditionType(AdditionTypeModel additionTypeModel);


}
