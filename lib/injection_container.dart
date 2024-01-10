import 'package:get_it/get_it.dart';
import 'package:malshy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:malshy/features/auth/domain/repositories/auth_repository.dart';
import 'package:malshy/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:malshy/features/auth/domain/usecases/register_usecase.dart';

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
}
