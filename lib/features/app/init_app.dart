import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/service_locator.dart';
import 'package:malshy/features/app/app.dart';
import 'package:malshy/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:malshy/injection_container.dart';

Future<void> initApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupKeyValueStorageService();

  setupApiService();

  await initializeDependencies();

  GetIt.I.registerSingleton<AuthBloc>(
    AuthBloc()
      ..add(
        AuthEvent.checkIfLoggedIn(),
      ),
  );

  runApp(
    App(),
  );
}
