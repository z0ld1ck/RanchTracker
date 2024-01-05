import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:malshy/features/cattle_list_page/data/models/farm_model.dart';
import '../repositories/live_stock_repository.dart';

class CreateLivestock extends UseCase<List<Livestock>, void> {
  final LiveStockRepository _liveStockRepository;

  CreateLivestock(this._liveStockRepository);

  @override
  Future<Stream<List<Livestock>?>> buildUseCaseStream(void params) {
    // TODO: implement buildUseCaseStream
    throw UnimplementedError();
  }
  
  
}
