import 'package:get_it/get_it.dart';
import 'package:malshy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';
import 'package:malshy/features/auth/domain/usecases/get_farm_id_usecase.dart';
import 'package:malshy/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:malshy/features/auth/domain/usecases/register_usecase.dart';
import 'package:malshy/features/livestock/data/repositories/live_stock_repository_impl.dart';
import 'package:malshy/features/livestock/domain/repositories/live_stock_repository.dart';
import 'package:malshy/features/livestock/domain/usecases/create_livestock_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/edit_livestock_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/get_addition_type_usecase.dart';
import 'package:malshy/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:malshy/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:malshy/features/dashboard/domain/usecase/get_dashboard_by_action_usecase.dart';
import 'package:malshy/features/dashboard/domain/usecase/get_dashboard_by_status_usecase.dart';
import 'package:malshy/features/dashboard/domain/usecase/get_dashboard_by_type_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/get_livestock_list_usecase.dart';
import 'package:malshy/features/livestock/domain/usecases/get_types_breeds_usecase.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /*
   * * AUTHENTICATION
   */

  // Dependencies
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());


  //UseCases
  sl.registerSingleton<LoginUsecase>(LoginUsecase(sl()));
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase(sl()));
  sl.registerSingleton<GetFarmIdUsecase>(GetFarmIdUsecase(sl()));


  /*
   * * LIVESTOCK
   */
  sl.registerSingleton<LiveStockRepository>(LiveStockRepositoryImpl());

  // usecases
  sl.registerSingleton<GetTypesAndBreedsUsecase>(GetTypesAndBreedsUsecase(sl()));
  sl.registerSingleton<GetLivestockListUsecase>(GetLivestockListUsecase(sl()));
  sl.registerSingleton<CreateLivestockUsecase>(CreateLivestockUsecase(sl()));
  sl.registerSingleton<GetAdditionTypeUseCase>(GetAdditionTypeUseCase(sl()));
  sl.registerSingleton<EditLivestockUsecase>(EditLivestockUsecase(sl()));
  
  /*
   * * DASHBOARD
   */
  sl.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());

  // usecases
  sl.registerSingleton<GetDashboardByTypeUsecase>(GetDashboardByTypeUsecase(sl()));
  sl.registerSingleton<GetDashboardByStatusUsecase>(GetDashboardByStatusUsecase(sl()));
  sl.registerSingleton<GetDashboardByActionUsecase>(GetDashboardByActionUsecase(sl()));
}
