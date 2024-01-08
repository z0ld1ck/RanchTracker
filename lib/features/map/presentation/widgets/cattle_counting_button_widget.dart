import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_icons.dart';
import '../../../../core/const/app_colors.dart';

class CattleCountingButtonWidget extends StatelessWidget {
  const CattleCountingButtonWidget({
    super.key,
    this.color,
    required this.onPressed,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.child,
    this.elevation,
    required this.text,
    this.icon,
  });

  final String? icon;
  final Widget? child;
  final Color? color;
  final Function() onPressed;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final double? elevation;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 19.w,
      height: 32.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: () {},
          child: Container(
            color: AppColors.blueLight,
            width: 140.w,
            height: 32.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    icon ?? AppIcons.drone,
                  ),
                  onPressed: () {},
                ),
                Text(
                  text ?? '',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
