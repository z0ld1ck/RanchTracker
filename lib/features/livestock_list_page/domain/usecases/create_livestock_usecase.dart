import 'package:dartz/dartz.dart';
import 'package:malshy/core/error/failures.dart';
import '../../data/models/livestock_model.dart';
import '../repositories/live_stock_repository.dart';

class CreateLiveStockUseCase {
  final LiveStockRepository _liveStockRepository;

  CreateLiveStockUseCase(this._liveStockRepository);

  Future<Either<DataFailed, LivestockModel>> call(LivestockModel livestock) async {
    return await _liveStockRepository.createLiveStock(livestock);
  }
}
