import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/routes/global_routes.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _number = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 45.h),
        child: SizedBox(
          height: Platform.isIOS ? 45.h : 25.h,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: ScreenUtil().setHeight(465),
            child: Transform.scale(
              scale: 1.35,
              child: Container(
                height: ScreenUtil().setHeight(400),
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Color(0xff2EA1D9),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(30),
            left: (ScreenUtil().screenWidth - ScreenUtil().setWidth(180)) / 2,
            child: Image.asset(
              'assets/images/Screenshot_1.png',
              height: ScreenUtil().setHeight(180),
              width: ScreenUtil().setWidth(180),
            ),
          ),
          Positioned(
            top: 201,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 50.w),
                      Text(
                        AppLocalizations.of(context)!.registration,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.splash);
                        },
                        icon: SvgPicture.asset(AppIcons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.subtext,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _name,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.fio,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      hintText:AppLocalizations.of(context)!.vvediteFio,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: _number,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.nomer,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                        hintText: '+7 (777) 777 77 77'),
                  ),
                  SizedBox(height: 16.h),
                  PrimaryButton(
                    onPressed: () async {
                      await navService.pushNamed(GlobalRoutes.sms);
                    },
                    color: AppColors.grayMedium,
                    text: AppLocalizations.of(context)!.getCode,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.account),
                      TextButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.login);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signin,
                          style:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.blueLight,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary(context),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
