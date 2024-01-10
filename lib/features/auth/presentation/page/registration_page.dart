import 'dart:io';
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

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController number = TextEditingController();

    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: Builder(
        builder: (context) {
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
                        Text(
                          AppLocalizations.of(context)!.subtext,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: AppColors.gray,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: name,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.fio,
                            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                            hintText: AppLocalizations.of(context)!.vvediteFio,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        TextField(
                          controller: number,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.nomer,
                              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                              hintText: '+7 (777) 777 77 77'),
                        ),
                        SizedBox(height: 16.h),
                        PrimaryButton(
                          onPressed: () async {
                            // await navService.pushNamed(GlobalRoutes.sms);
                            // TODO: validate phone number and check if name is not empty
                            final nameList = name.text.split(' ');
                            if (nameList.length >= 2) {
                              context.read<RegistrationBloc>().add(
                                    RegistrationEvent.getSMScode(
                                      phone: number.text.trim(),
                                      firstName: nameList[0],
                                      lastName: nameList[1],
                                      thirdName: nameList.length > 2 ? nameList[2] : '',
                                    ),
                                  );
                              context.pushNamed(RouteNames.sms.name, extra: context.read<RegistrationBloc>());
                            }
                          },
                          color: AppColors.grayMedium,
                          text: AppLocalizations.of(context)!.getCode,
                        ),
                        SizedBox(height: 16.h),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
