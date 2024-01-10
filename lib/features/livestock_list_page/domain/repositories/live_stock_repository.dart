import 'package:dartz/dartz.dart';
import 'package:malshy/core/error/data_state.dart';
import '../../data/models/livestock_model.dart';
import '../entities/livestock_entity.dart';

abstract class LiveStockRepository {
  Future<DataState<LivestockModel>> createLiveStock(
      LivestockModel livestockModel);
}
