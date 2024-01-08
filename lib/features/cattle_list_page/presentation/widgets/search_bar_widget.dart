import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 343.w,
        height: 44.h,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: 'Поиск животных по ушной бирке и имени',
            hintStyle:
                Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.gray, fontWeight: FontWeight.w400),
            border: OutlineInputBorder(),
            filled: true,
            fillColor: AppColors.white,
            prefixIcon: IconButton(
              icon: SvgPicture.asset(AppIcons.search2),
              onPressed: () {},
            ),
            suffixIcon: IconButton(
              icon: SvgPicture.asset(AppIcons.filter),
              onPressed: () {
                context.goNamed(RouteNames.cattleListFilter.name);
              },
            ),
          ),
        ),
      ),
    );
  }
}
