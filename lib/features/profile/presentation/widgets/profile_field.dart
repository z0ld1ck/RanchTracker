import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';

class ProfileField extends StatefulWidget {
  const ProfileField({super.key});

  @override
  State<ProfileField> createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         padding:EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          decoration: BoxDecoration(
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
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '+7 702 977 4926',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 110.w,
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.logout),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
