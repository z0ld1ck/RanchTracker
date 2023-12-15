import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/services/shared_pref.dart';
import 'package:malshy/core/theme/theme.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';

import '../auth/presentation/page/sms_code_auth.dart';
import '../auth/presentation/page/test.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: APP_THEME,
          navigatorKey: NavigationService.navigationKey,
          onGenerateRoute: (RouteSettings settings) {
            if (!sharedPreference.isAuthenticated) {
              return MaterialPageRoute(builder: (_) => AuthPage());
            }

            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => HomePage());
              case '/auth_screen':
                return MaterialPageRoute(builder: (_) => AuthPage());
              default:
                return null;
            }
          },
        );
      },
    );
  }
}
