import 'package:get_it/get_it.dart';
import 'package:malshy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';
import 'package:malshy/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:malshy/features/auth/domain/usecases/register_usecase.dart';
import 'package:malshy/features/livestock_list_page/data/repositories/live_stock_repository_impl.dart';
import 'package:malshy/features/livestock_list_page/domain/repositories/live_stock_repository.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/create_livestock_usecase.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_addition_type_usecase.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_types_and_breeds_usecase.dart';
import 'package:malshy/features/dashboard_page/data/repositories/dashboard_repository_impl.dart';
import 'package:malshy/features/dashboard_page/domain/repositories/dashboard_repository.dart';
import 'package:malshy/features/dashboard_page/domain/usecase/get_dashboard_by_action_usecase.dart';
import 'package:malshy/features/dashboard_page/domain/usecase/get_dashboard_by_status_usecase.dart';
import 'package:malshy/features/dashboard_page/domain/usecase/get_dashboard_by_type_usecase.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_livestock_list_usecase.dart';
import 'package:malshy/features/livestock_list_page/domain/usecases/get_types_breeds_usecase.dart';


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
  sl.registerSingleton<GetTypesAndBreedsUseCase>(GetTypesAndBreedsUseCase(sl()));
  sl.registerSingleton<GetAdditionTypeUseCase>(GetAdditionTypeUseCase(sl()));

  /*
   * * LIVESTOCK
   */
  sl.registerSingleton<LiveStockRepository>(LiveStockRepositoryImpl());

  // usecases
  sl.registerSingleton<GetTypesBreedsUsecase>(GetTypesBreedsUsecase(sl()));
  sl.registerSingleton<GetLivestockListUsecase>(GetLivestockListUsecase(sl()));

  /*
   * * DASHBOARD
   */
  sl.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());

  // usecases
  sl.registerSingleton<GetDashboardByTypeUsecase>(GetDashboardByTypeUsecase(sl()));
  sl.registerSingleton<GetDashboardByStatusUsecase>(GetDashboardByStatusUsecase(sl()));
  sl.registerSingleton<GetDashboardByActionUsecase>(GetDashboardByActionUsecase(sl()));
}
