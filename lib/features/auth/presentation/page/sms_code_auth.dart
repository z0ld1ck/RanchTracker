import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:pinput/pinput.dart';

class SMSCodeAuthPage extends StatefulWidget {
  const SMSCodeAuthPage({super.key});

  @override
  State<SMSCodeAuthPage> createState() => _SMSCodeAuthPageState();
}

class _SMSCodeAuthPageState extends State<SMSCodeAuthPage> {
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
      textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.black),
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
                          context.pop();
                        },
                        icon: SvgPicture.asset(AppIcons.back),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.registration,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.subtext2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.gray),
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
                          context.pushNamed(RouteNames.password.name);
                        }
                        return AppLocalizations.of(context)!.wrongCode;
                      },
                      errorTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.error),
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
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.resend,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.blueLight),
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
