import 'package:flutter/material.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';

class GlobalRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register='/register';
  static const String sms='/sms';
  static const String password='/password';

  // static List<String> get needAuthRoutes {
  //   return [profile, farm];
  // }

  static Route routes(RouteSettings settings) {
    String? routeName = settings.name;
    // dynamic args = settings.arguments;

    // if (!sharedPreference.isAuthenticated) {
    //   return MaterialPageRoute(builder: (context) => LogInPage());
    // }

    Widget getPage() {
      switch (routeName) {
      ///Home page
        case home:
          return const HomePage();
      ///Register page
        case register:
          return const AuthPage();
      ///Sms page
        case sms:
          return const SmSCodeAuthPage();
      ///New password page
        case password:
          return const PasswordPage();
      ///LogIn page
        case login:
          return const LogInPage();
      ///Not found page
        default:
          return const Splash();
      }
    }

    return MaterialPageRoute(builder: (context) => getPage());
  }
}