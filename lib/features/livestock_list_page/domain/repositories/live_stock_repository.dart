import 'package:dartz/dartz.dart';
import 'package:malshy/core/error/data_state.dart';
import '../../data/models/livestock_model.dart';

abstract class LiveStockRepository {
  Future<DataState<LivestockModel>> createLiveStock(
      LivestockModel livestockModel);
}
