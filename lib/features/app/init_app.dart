import 'package:flutter/material.dart';
import 'package:malshy/features/app/app.dart';
import 'package:malshy/injection_container.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(App());
}
