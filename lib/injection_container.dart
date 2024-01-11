import 'package:get_it/get_it.dart';
import 'package:malshy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';
import 'package:malshy/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:malshy/features/auth/domain/usecases/register_usecase.dart';
import 'package:malshy/features/livestock_list_page/data/repositories/live_stock_repository_impl.dart';
import 'package:malshy/features/livestock_list_page/domain/repositories/live_stock_repository.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/create_livestock_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /*
   * * AUTHENTICATION
   */

  // Dependencies
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<LiveStockRepository>(LiveStockRepositoryImpl());

  //UseCases
  sl.registerSingleton<LoginUsecase>(LoginUsecase(sl()));
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase(sl()));
  sl.registerSingleton<CreateLiveStockUseCase>(CreateLiveStockUseCase(sl()));
}
