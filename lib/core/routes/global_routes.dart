import 'package:flutter/material.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';
import 'package:malshy/presentation/home/pages/cattle_list_page.dart';
import 'package:malshy/presentation/home/pages/dashboard_page.dart';
import 'package:malshy/presentation/home/pages/home_page.dart';
import '../../presentation/home/nested/add_cattle_page.dart';
import '../../presentation/home/nested/filter.dart';
import '../../presentation/home/pages/events_page.dart';
import '../../presentation/home/pages/map_page.dart';
import '../../presentation/home/pages/profile.dart';

class GlobalRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String sms = '/sms';
  static const String password = '/password';
  static const String cattleList = '/cattleList';
  static const String dashboard = '/dashboard';
  static const String event = '/event';
  static const String map = '/map';
  static const String profile = '/profile';
  static const String nav = '/nav';
  static const String filter = '/filter';
  static const String addCattle = '/addCattle';

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
        case GlobalRoutes.dashboard:
          return Dashboard();
        case GlobalRoutes.cattleList:
          return CattleListPage();
        case GlobalRoutes.event:
          return Events();
        case GlobalRoutes.map:
          return MapPage();
        case GlobalRoutes.profile:
          return Profile();
        case GlobalRoutes.nav:
          return Home();
        case GlobalRoutes.filter:
          return FilterPage();
        case GlobalRoutes.addCattle:
          return AddCattlePage();
        default:
          return const Splash();
      }
    }

    return MaterialPageRoute(builder: (context) => getPage());
  }
}
