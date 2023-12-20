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
          locale: const Locale('kk'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          theme: APP_THEME,
          navigatorKey: NavigationService.navigationKey,
          onGenerateRoute: GlobalRoutes.routes,
        );
      },
    );
  }
}