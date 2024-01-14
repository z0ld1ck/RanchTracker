import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/livestock_list_page/data/models/get_livestock_model.dart';
import 'package:malshy/features/livestock_list_page/data/models/type_model.dart';
import '../../data/models/livestock_model.dart';

abstract class LiveStockRepository {
  Future<DataState<LivestockModel>> createLiveStock(LivestockModel livestockModel);

  Future<DataState<List<GetLivestockModel>>> getLiveStock({required Map<String, dynamic> queryParams});

  Future<DataState<List<TypeModel>>> getTypesBreeds();
}
