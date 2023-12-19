import 'package:flutter/material.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';

class GlobalRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register='/register';
  static const String sms='/sms';
  static const String password='/password';

  // static List<String> get needAuthRoutes {
  //   return [profile, farm];
  // }

  static Route routes(RouteSettings settings) {
    String? routeName = settings.name;
    dynamic args = settings.arguments;

    // if (!sharedPreference.isAuthenticated) {
    //   return MaterialPageRoute(builder: (context) => LogInPage());
    // }

    Widget getPage() {
      switch (routeName) {
        ///Home page
        case home:
          return const HomePage();
        case register:
          return const AuthPage();
        case sms:
          return const SmSCodeAuthPage();
        case password:
          return const PasswordPage();
        case login:
          return const LogInPage();
          ///Not found page
        default:
          return const HomePage();
      }
    }

    return MaterialPageRoute(builder: (context) => getPage());
  }
}
