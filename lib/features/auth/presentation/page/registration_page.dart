import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/core/widgets/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:malshy/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late final PhoneController _phoneNumberController;

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _phoneNumberController = PhoneController(const PhoneNumber(isoCode: IsoCode.KZ, nsn: ''));
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _formKey.currentState?.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              top: 201.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 32.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: Colors.white,
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
                              AppLocalizations.of(context)!.registration,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.black),
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
                      // subtext
                      Text(
                        AppLocalizations.of(context)!.subtext,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.gray,
                            ),
                      ).paddingOnly(top: 12.h, bottom: 16.h),
                      // name text field
                      TextFormField(
                        controller: _nameController,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.vvediteFio;
                          }
                          final name = value.trim().split(' ');
                          if (name.length < 2) {
                            return AppLocalizations.of(context)!.vvediteFio;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.fio,
                          labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                          hintText: AppLocalizations.of(context)!.vvediteFio,
                        ),
                      ),
                      // phone text field
                      PhoneFormField(
                        controller: _phoneNumberController,
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
                        shouldFormat: true,
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
                      // get code button
                      PrimaryButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate() &&
                              _phoneNumberController.value != null) {
                            final name = _nameController.text.split(' ');
                              context.read<RegistrationBloc>().add(
                                  RegistrationEvent.getSMScode(
                                    phone:
                                        '+${_phoneNumberController.value!.countryCode}${_phoneNumberController.value!.nsn.trim()}',
                                    firstName: name[0],
                                    lastName: name[1],
                                    thirdName: name.length > 2 ? name[2] : '',
                                  ),
                                );
                            context.pushNamed(RouteNames.sms.name, extra: context.read<RegistrationBloc>());
                          }
                        },
                        color: AppColors.grayMedium,
                        text: AppLocalizations.of(context)!.getCode,
                      ).paddingOnly(bottom: 12.h),
                      // go to login page textbutton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${AppLocalizations.of(context)!.account} '),
                          InkWell(
                            onTap: () {
                              context.pushReplacementNamed(RouteNames.login.name);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signin,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.primary(context),
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
            ),
          ],
        ),
      ),
    );
  }
}
