import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:malshy/features/auth/presentation/bloc/registration/registration_bloc.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) async {
        EasyLoading.removeAllCallbacks();
        EasyLoading.instance
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 75.w
          ..indicatorType = EasyLoadingIndicatorType.circle
          ..indicatorColor = Color(0xFF2EA1D9)
          ..backgroundColor = Colors.white
          ..maskColor = Colors.white
          ..animationDuration = Duration.zero
          ..animationStyle = EasyLoadingAnimationStyle.offset
          ..textColor = AppColors.primary(context)
          ..animationStyle = EasyLoadingAnimationStyle.scale
          ..userInteractions = true
          ..successWidget = SvgPicture.asset('assets/icons/success.svg')
          ..boxShadow = const []
          ..dismissOnTap = false;
        if (state.status == RegistrationStatus.success) {
          await EasyLoading.showSuccess(
            '',
            duration: 1.seconds,
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: true,
          );
          if (context.mounted) context.go(RouteNames.welcome.path);
          if (context.mounted) context.push(RouteNames.login.path);
        } else if (state.status == RegistrationStatus.failed) {
          await EasyLoading.showError(
            '',
            duration: 1.seconds,
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: true,
          );
        } else if (state.status == RegistrationStatus.loading) {
          await EasyLoading.show(
            maskType: EasyLoadingMaskType.custom,
            dismissOnTap: false,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                top: 201.h,
                left: 16.w,
                right: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: AppColors.white,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        // title
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                AppLocalizations.of(context)!.newPassword,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.black),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: IconButton(
                                iconSize: 24.h,
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  context.pop();
                                },
                                icon: SvgPicture.asset(
                                  AppIcons.back,
                                  height: 24.h,
                                  width: 24.h,
                                ),
                              ),
                            ),
                          ],
                        ).paddingOnly(bottom: 18.h),
                        // password
                        TextFormField(
                          obscureText: _obscureText,
                          controller: _passwordController,
                          obscuringCharacter: '*',
                          maxLines: 1,
                          validator: (value) {
                            final numericRegExp = RegExp(r'[0-9]');
                            final specialCharRegExp =
                                RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' // <-- Notice the escaped symbols
                                    "'" // <-- ' is added to the expression
                                    ']');
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (!value.hasCapitalletter() ||
                                !value.contains(specialCharRegExp) ||
                                !value.contains(numericRegExp) ||
                                value.length < 8) {
                              return 'The password must contain: 1 capital letter, number, special character. Minimum number of characters - 8';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.passwd,
                            labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.black),
                            hintText: AppLocalizations.of(context)!.vveditePassword,
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? SvgPicture.asset(
                                      'assets/icons/visibility_off.svg',
                                      color: Color(0xFFA7A7A7),
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/visibility.svg',
                                      color: Color(0xFFA7A7A7),
                                    ),
                              onPressed: () {
                                _obscureText = !_obscureText;
                                setState(() {});
                              },
                            ),
                          ),
                        ).paddingOnly(bottom: 16.h),
                        // repeat password
                        TextFormField(
                          obscureText: _obscureText2,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value != _passwordController.text.trim()) {
                              return 'Passwords do not match';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: _obscureText2
                                    ? SvgPicture.asset(
                                        'assets/icons/visibility_off.svg',
                                        color: Color(0xFFA7A7A7),
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/visibility.svg',
                                        color: Color(0xFFA7A7A7),
                                      ),
                                onPressed: () {
                                  _obscureText2 = !_obscureText2;
                                  setState(() {});
                                },
                              ),
                              labelText: AppLocalizations.of(context)!.repeatPassword,
                              labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.black),
                              hintText: AppLocalizations.of(context)!.repeatPassword),
                        ).paddingOnly(bottom: 16.h),
                        // register button
                        PrimaryButton(
                          text: AppLocalizations.of(context)!.save,
                          color: AppColors.grayMedium,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              context.read<RegistrationBloc>().add(
                                    RegistrationEvent.register(
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
