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
import 'package:phone_form_field/phone_form_field.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late final PhoneController _phoneNumberController;
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void initState() {
    _phoneNumberController = PhoneController(const PhoneNumber(isoCode: IsoCode.KZ, nsn: ''));
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _formKey.currentState?.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<AuthBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) => previous.localState != current.localState,
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

              if (state.localState == AuthLocalState.success) {
                await EasyLoading.showSuccess(
                  '',
                  duration: 1.seconds,
                  maskType: EasyLoadingMaskType.custom,
                  dismissOnTap: true,
                );
                if (context.mounted) context.go(RouteNames.dashboard.path);
              } else if (state.localState == AuthLocalState.failed) {
                await EasyLoading.showError(
                  '',
                  duration: 1.seconds,
                  maskType: EasyLoadingMaskType.custom,
                  dismissOnTap: true,
                );
              } else if (state.localState == AuthLocalState.loading) {
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
                          autovalidateMode: autovalidateMode,
                          child: Column(
                            children: [
                              // title
                              Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      AppLocalizations.of(context)!.signin,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.black),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
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
                                        AppIcons.close,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // phone text field
                              PhoneFormField(
                                controller: _phoneNumberController,
                                shouldFormat: true,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.nomer,
                                  hintText: '(777) 777 77 77',
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    height: 1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                defaultCountry: IsoCode.KZ,
                                //TODO: поменять стиль когда настроишь inputDecorationTheme
                                countryCodeStyle: const TextStyle(
                                  color: Colors.black, // (0xFF9D9D9D),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  height: 1,
                                  fontWeight: FontWeight.w400,
                                ),
                                validator: PhoneValidator.valid(
                                    allowEmpty: false,
                                    // TODO: AppLocalizations
                                    errorText: 'Номер телефона не может быть пустым'),
                                isCountryChipPersistent: true,
                                isCountrySelectionEnabled: true,
                                countrySelectorNavigator: CountrySelectorNavigator.modalBottomSheet(
                                  height: context.height * 0.75,
                                  favorites: [
                                    IsoCode.KZ,
                                    IsoCode.UA,
                                    IsoCode.UZ,
                                    IsoCode.KG,
                                    IsoCode.TJ,
                                    IsoCode.TM,
                                  ],
                                  addSeparator: false,
                                ),
                                showFlagInInput: false,
                                autovalidateMode: autovalidateMode,
                                flagSize: 24,
                                enabled: true,
                                autofocus: false,
                              ).paddingSymmetric(vertical: 16.h),
                              // password text field
                              TextFormField(
                                obscureText: _obscureText,
                                obscuringCharacter: '*',
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.vveditePassword;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.passwd,
                                  labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        color: AppColors.gray,
                                      ),
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
                              ),
                              // sign in button
                              PrimaryButton(
                                text: AppLocalizations.of(context)!.signin,
                                color: AppColors.grayMedium,
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate() &&
                                      _phoneNumberController.value != null) {
                                    context.read<AuthBloc>().add(
                                          AuthEvent.logIn(
                                            phone:
                                                '+${_phoneNumberController.value!.countryCode}${_phoneNumberController.value!.nsn.trim()}',
                                            password: _passwordController.text.trim(),
                                          ),
                                        );
                                  }
                                  autovalidateMode = AutovalidateMode.onUserInteraction;
                                  setState(() {});
                                },
                              ).paddingOnly(bottom: 12.h, top: 16.h),
                              // no account
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
                              ).paddingOnly(bottom: 12.h),
                              // recover password
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
