import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/widgets/primary_button.dart';

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
                        'Регистрация',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          navService.pushNamed('/');
                        },
                        icon: SvgPicture.asset(AppIcons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Введите номер телефона,и мы отправим вам код подтверждения',
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
                      labelText: 'ФИО',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      hintText: 'Введите ФИО',
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextField(
                    controller: _number,
                    decoration: InputDecoration(
                        labelText: 'Номер телефона',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.black),
                        hintText: '+7 (777) 777 77 77'),
                  ),
                  SizedBox(height: 16.h),
                  PrimaryButton(
                    onPressed: () async {
                      await navService.pushNamed('/sms_code_page');
                    },
                    color: AppColors.grayMedium,
                    text: 'Получить код подтверждения',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Eсть аккаунт?'),
                      TextButton(
                        onPressed: () {
                          navService.pushNamed('/login_page');
                        },
                        child: Text(
                          'Войти',
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
