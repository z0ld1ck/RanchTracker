import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/routes/global_routes.dart';
import 'package:malshy/core/theme/theme.dart';
import 'package:malshy/features/app/home_page.dart';
import 'package:malshy/features/auth/presentation/page/auth.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../auth/presentation/page/sms_code_auth.dart';

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
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          theme: APP_THEME,
          navigatorKey: NavigationService.navigationKey,
          // onGenerateRoute: GlobalRoutes.routes,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case GlobalRoutes.home:
                return MaterialPageRoute(builder: (_) => HomePage());
              case GlobalRoutes.register:
                return MaterialPageRoute(builder: (_) => AuthPage());
              case GlobalRoutes.login:
                return MaterialPageRoute(builder: (_) => LogInPage());
              case GlobalRoutes.sms:
                return MaterialPageRoute(builder: (_) => SmSCodeAuthPage());
              case GlobalRoutes.password:
                return MaterialPageRoute(builder: (_) => PasswordPage());
              case GlobalRoutes.splash:
                return MaterialPageRoute(builder: (_) => Splash());
              default:
                return null;
            }
          },
        );
      },
    );
  }
}