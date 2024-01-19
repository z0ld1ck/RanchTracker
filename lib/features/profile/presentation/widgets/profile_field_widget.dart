import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/features/auth/presentation/bloc/auth/auth_bloc.dart';

class ProfileFieldWidget extends StatefulWidget {
  const ProfileFieldWidget({super.key});

  @override
  State<ProfileFieldWidget> createState() => _ProfileFieldWidgetState();
}

class _ProfileFieldWidgetState extends State<ProfileFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              CircleAvatar(
                radius: 25.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Асхат Нариманов',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.black, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '+7 702 977 4926',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.black, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 110.w,
              ),
              IconButton(
                onPressed: () {
                  GetIt.I<AuthBloc>().add(AuthEvent.logOut());
                  context.go(RouteNames.welcome.path);
                },
                icon: SvgPicture.asset(AppIcons.logout),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
