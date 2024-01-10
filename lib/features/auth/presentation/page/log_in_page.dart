import 'dart:io';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/auth/presentation/bloc/auth/auth_bloc.dart';

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
    return BlocProvider.value(
      value: GetIt.I<AuthBloc>(),
      child: Builder(builder: (context) {
        return BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.localState != current.localState,
          listener: (context, state) async {
            EasyLoading.removeAllCallbacks();

            if (state.localState == AuthLocalState.success) {
              EasyLoading.showSuccess('Great Success!', duration: 1.5.seconds);
              await 1.5.delay();
              if (context.mounted) context.go(RouteNames.dashboard.path);
            } else if (state.localState == AuthLocalState.failed) {
              EasyLoading.showError('Failed!', duration: 1.5.seconds);
            } else if (state.localState == AuthLocalState.loading) {
              EasyLoading.show(status: 'loading...');
            }
          },
          child: Scaffold(
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
                  top: ScreenUtil().setHeight(201),
                  left: ScreenUtil().setWidth(16),
                  right: ScreenUtil().setWidth(16),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 30.w),
                            Text(
                              AppLocalizations.of(context)!.signin,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                context.pop();
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
                            labelText: AppLocalizations.of(context)!.nomer,
                            labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.gray),
                            hintText: '+7 (777) 777 77 77',
                          ),
                        ),
                        SizedBox(height: 15.h),
                        TextField(
                          obscureText: _obsecureText,
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.passwd,
                            labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.gray),
                            hintText: AppLocalizations.of(context)!.vveditePassword,
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
                          text: AppLocalizations.of(context)!.signin,
                          color: AppColors.grayMedium,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthEvent.logIn(
                                    phone: _number.text.trim(),
                                    password: _password.text.trim(),
                                  ),
                                );
                          },
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${AppLocalizations.of(context)!.noaccount} '),
                            InkWell(
                              onTap: () {
                                context.pushReplacement(RouteNames.registration.path);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signup,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppColors.primary(context),
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primary(context),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${AppLocalizations.of(context)!.forgot} '),
                            Text(
                              AppLocalizations.of(context)!.recover,
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
          ),
        );
      }),
    );
  }
}
