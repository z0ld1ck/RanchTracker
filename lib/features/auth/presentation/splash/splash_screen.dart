import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

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
              // 'Добро пожаловать в ',
              AppLocalizations.of(context)!.greeting,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.white),
            ),
            Text(
              'MALSHI',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              onPressed: () async {
                await navService.pushNamed('/login_page');
              },
              child: Text(
                // 'Войти',
                AppLocalizations.of(context)!.signin,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SizedBox(height: 12.h),
            PrimaryButton(
              onPressed: () async {
                await navService.pushNamed('/auth_screen');
              },
              borderColor: AppColors.blueLight,
              borderWidth: 3,
              elevation: 0,
              color: Colors.transparent,
              child: Text(
                // 'Зарегистрироваться',
                AppLocalizations.of(context)!.signup,
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
