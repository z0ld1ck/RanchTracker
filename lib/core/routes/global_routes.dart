import 'package:flutter/material.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';

import '../services/shared_pref.dart';

class GlobalRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String sms = '/sms';
  static const String password = '/password';

  // static List<String> get needAuthRoutes {
  //   return [profile, farm];
  // }

  static Route routes(RouteSettings settings) {
    String? routeName = settings.name;
    // dynamic args = settings.arguments;

    Widget getPage() {
      // if (!sharedPreference.isAuthenticated) {
      //   return HomePage();
      // }
      switch (routeName) {
        case GlobalRoutes.splash:
          return Splash();
        case GlobalRoutes.register:
          return AuthPage();
        case GlobalRoutes.login:
          return LogInPage();
        case GlobalRoutes.sms:
          return SmSCodeAuthPage();
        case GlobalRoutes.password:
          return PasswordPage();
        case GlobalRoutes.home:
          return HomePage();
        default:
          return const Splash();
      }
    }

    return MaterialPageRoute(builder: (context) => getPage());
  }
}