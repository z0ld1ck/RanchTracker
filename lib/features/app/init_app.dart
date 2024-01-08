import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/service_locator.dart';
import 'package:malshy/features/app/app.dart';
import 'package:malshy/features/auth/presentation/bloc/auth_bloc.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupKeyValueStorageService();

  setupApiService();

  GetIt.I.registerSingleton<AuthBloc>(
    AuthBloc()..add(AuthEvent.checkIfLoggedIn()),
  );

  runApp(App());
}
