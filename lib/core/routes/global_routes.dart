import 'package:flutter/material.dart';
import 'package:malshy/core/services/shared_pref.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';

class GlobalRoutes {
  static const String home = '/';
  static const String login = '/login';

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

        ///Not found page
        default:
          return const HomePage();
      }
    }

    return MaterialPageRoute(builder: (context) => getPage());
  }
}
