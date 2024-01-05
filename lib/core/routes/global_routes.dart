import 'package:flutter/material.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';
import 'package:malshy/features/cattle_list_page/presentation/pages/cattle_list_page.dart';
import 'package:malshy/features/dashboard_page/presentation/pages/dashboard_page.dart';
import 'package:malshy/features/events/presentation/pages/internal_movements_page.dart';
import '../../features/cattle_list_page/presentation/pages/add_cattle_page.dart';
import '../../features/cattle_list_page/presentation/pages/filter.dart';
import '../../features/events/presentation/pages/sales_page.dart';
import '../../features/events/presentation/pages/events_page.dart';
import '../../features/events/presentation/pages/loss_page.dart';
import '../../features/events/presentation/pages/pregnancy_page.dart';
import '../../features/events/presentation/pages/prevention_page.dart';
import '../../features/events/presentation/pages/slaughter_page.dart';
import '../../features/events/presentation/pages/treatment_page.dart';
import '../../features/events/presentation/pages/weight_measure_page.dart';
import '../../features/map/presentation/pages/map_page.dart';
import '../../features/profile/presentation/pages/profile.dart';

class GlobalRoutes {
  static const String splash = '/';
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
  static const String intmove = '/intmove';

  static const String prevention = '/prevention';
  static const String treatment = '/treatment';
  static const String weight = '/weight';
  static const String sales = '/sales';
  static const String slaughter = '/slaughter';
  static const String loss = '/loss';
  static const String pregnancy = '/pregnancy';

  static Route routes(RouteSettings settings) {
    String? routeName = settings.name;
    // dynamic args = settings.arguments;

    Widget getPage() {
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
        case GlobalRoutes.dashboard:
          return DashboardPage();
        case GlobalRoutes.cattleList:
          return CattleListPage();
        case GlobalRoutes.event:
          return Events();
        case GlobalRoutes.map:
          return MapPage();
        case GlobalRoutes.profile:
          return Profile();
        case GlobalRoutes.nav:
          return HomePage();
        case GlobalRoutes.filter:
          return FilterPage();
        case GlobalRoutes.addCattle:
          return AddCattlePage();
        case GlobalRoutes.intmove:
          return InternalMovements();
        case GlobalRoutes.prevention:
          return Prevention();
        case GlobalRoutes.treatment:
          return Treatment();
        case GlobalRoutes.weight:
          return WeightMeasurement();
        case GlobalRoutes.sales:
          return Sales();
        case GlobalRoutes.slaughter:
          return Slaughter();
        case GlobalRoutes.loss:
          return Loss();
        case GlobalRoutes.pregnancy:
          return Pregnancy();
        default:
          return const Splash();
      }
    }

    return MaterialPageRoute(builder: (context) => getPage());
  }
}
