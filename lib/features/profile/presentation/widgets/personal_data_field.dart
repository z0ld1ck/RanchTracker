import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Номер телефона',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                '+7 777 777 77 77 ',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.gray, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Divider(
            color: AppColors.grayLight,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Пароль',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w600),
              ),
              SizedBox(width:255.w,),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.next),
              ),
            ],
          )
        ],
      ),
    );
  }
}
