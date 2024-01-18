import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';

abstract class LiveStockRepository {
  Future<DataState<LivestockModel>> createLivestock(LivestockModel livestockModel);

  Future<DataState<LivestockModel>> editLivestock(LivestockModel livestockModel, List<int> deletedImages);

  Future<DataState<List<AdditionTypeModel>>> getAdditionType();

  Future<DataState<List<LivestockModel>>> getLiveStock({required Map<String, dynamic> queryParams});

  Future<DataState<List<TypeModel>>> getTypesAndBreeds();
}
