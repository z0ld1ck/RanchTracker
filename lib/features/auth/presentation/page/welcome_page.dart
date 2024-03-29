import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splash,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.0.w),
        child: Column(
          children: [
            SizedBox(height: 131.h),
            Transform.scale(
              scale: 0.5,
              child: Image.asset('assets/images/Screenshot_3.png'),
            ),
            Text(
              AppLocalizations.of(context)!.greeting, // 'Добро пожаловать в',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.white),
            ),
            Text(
              'MALSHI',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              onPressed: () {
                context.push(RouteNames.login.path);
              },
              child: Text(
                AppLocalizations.of(context)!.signin, // 'Войти'
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SizedBox(height: 12.h),
            PrimaryButton(
              onPressed: () {
                context.push(RouteNames.registration.path);
              },
              borderColor: AppColors.blueLight,
              borderWidth: 3,
              elevation: 0,
              color: Colors.transparent,
              child: Text(
                AppLocalizations.of(context)!.signup, // 'Зарегистрироваться',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
