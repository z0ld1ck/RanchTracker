import 'package:dartz/dartz.dart';
import 'package:malshy/core/error/failures.dart';
import '../../data/models/livestock_model.dart';
import '../entities/livestock_entity.dart';

abstract class LiveStockRepository {
  Future<Either<DataFailed, LivestockModel>> createLiveStock(LivestockModel livestock);
}
