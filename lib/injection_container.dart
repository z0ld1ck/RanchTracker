import 'package:get_it/get_it.dart';
import 'package:malshy/core/services/shared_pref.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /*
   * * 
   */
  await sharedPreference.init();
}
