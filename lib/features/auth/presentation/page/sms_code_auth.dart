import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:pinput/pinput.dart';

class SmSCodeAuthPage extends StatefulWidget {
  const SmSCodeAuthPage({super.key});

  @override
  State<SmSCodeAuthPage> createState() => _SmSCodeAuthPageState();
}

class _SmSCodeAuthPageState extends State<SmSCodeAuthPage> {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool showError = false;

  @override
  void dispose() {
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColors.black),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 45.h),
        child: SizedBox(
          height: Platform.isIOS ? 45.h : 25.h,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            bottom: ScreenUtil().setHeight(420),
            child: Transform.scale(
              scale: 1.35,
              child: Container(
                height: ScreenUtil().setHeight(600),
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
              height: 180,
              width: 180,
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
                color: Colors.white,
              ),
              height: ScreenUtil().setHeight(450),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          navService.pushNamed('/auth_screen');
                        },
                        icon: SvgPicture.asset(AppIcons.back),
                      ),
                      SizedBox(width:50.w,),
                      Text(
                        'Регистрация',
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Введите код, который мы отправили на номер          +7 707 695 08 16',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.gray),
                  ),
                  SizedBox(height: 12.h),
                  Form(
                    key: formKey,
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      length: 4,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      onCompleted: (pin) {
                        setState(() => showError = pin != '5555');
                      },
                      validator: (pin) {
                        if (pin == '1111') {
                          navService.pushNamed('/password');
                        }
                        ;
                        return 'Неправильный код.Попробуйте снова';
                      },
                      errorTextStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.error),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: AppColors.blueLight),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.error),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () {
                      navService.pushNamed('/password');
                    },
                    child: Text(
                      'Отправить заново',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.blueLight),
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
