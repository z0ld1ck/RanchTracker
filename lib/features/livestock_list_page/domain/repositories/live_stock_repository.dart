import 'package:malshy/core/utils/data_state.dart';
import '../../data/models/livestock_model.dart';

abstract class LiveStockRepository {
  Future<DataState<LivestockModel>> createLiveStock(
      LivestockModel livestockModel);
}
