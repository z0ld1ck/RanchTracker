import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/auth/presentation/splash/splash_screen.dart';

import '../../../../core/navigation/nav_services.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _number = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
            bottom: ScreenUtil().setHeight(520),
            left: 0,
            right: 0,
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
            top: ScreenUtil().setHeight(201),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
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
                      SizedBox(width: 30.w),
                      Text(
                        'Войти',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.push(
                            MaterialPageRoute(
                              builder: (_) => Splash(),
                            ),
                          );
                        },
                        icon: SvgPicture.asset(AppIcons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _number,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Номер телефона',
                      labelStyle: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w200,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                      hintText: '+7 (777) 777 77 77',
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    obscureText: _obsecureText,
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      labelStyle: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w200,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                      hintText: 'Введите пароль',
                      suffixIcon: IconButton(
                        icon: Icon(_obsecureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  PrimaryButton(
                    text: 'Войти',
                    color: AppColors.grayMedium,
                    onPressed: () async {
                      await navService.pushNamed('/sms_code_page');
                    },
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Нет аккаунта? '),
                      Text(
                        'Зарегистрироваться',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary(context),
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary(context),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Забыли пароль? '),
                      Text(
                        'Восстановить',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.primary(context),
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary(context),
                            ),
                      ),
                    ],
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
