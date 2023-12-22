import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/routes/global_routes.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
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
            bottom: ScreenUtil().setHeight(420),
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.35,
              child: Container(
                height: ScreenUtil().setHeight(600),
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
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
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.white,
              ),
              height: ScreenUtil().setHeight(450),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          navService.pushNamed(GlobalRoutes.sms);
                        },
                        icon: SvgPicture.asset(AppIcons.back),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.newPassword,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 19.h),
                  TextField(
                    obscureText: _obsecureText,
                    controller: _passwordController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.passwd,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.black),
                      hintText: AppLocalizations.of(context)!.vveditePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    obscureText: true,
                    // controller: _number,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                        ),
                        labelText: AppLocalizations.of(context)!.repeatPassword,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.black),
                        hintText: AppLocalizations.of(context)!.repeatPassword),
                  ),
                  SizedBox(height: 16.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        navService.pushNamed(GlobalRoutes.event);
                      },
                      child: Container(
                        color: AppColors.grayMedium,
                        width: ScreenUtil().setWidth(330),
                        height: ScreenUtil().setHeight(60),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.save,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
