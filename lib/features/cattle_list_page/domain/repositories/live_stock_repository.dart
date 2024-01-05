import 'package:malshy/features/cattle_list_page/data/models/farm_model.dart';

abstract class LiveStockRepository {
  Future<Livestock> createLivestock();
}
