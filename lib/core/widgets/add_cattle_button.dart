import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_icons.dart';

import '../const/app_colors.dart';

class AddCattleButton extends StatelessWidget {
  const AddCattleButton({
    Key? key,
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
      width: 185.w,
      height: 32.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: borderWidth ?? 0,
                ),
              );
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.blueLight.withOpacity(0.8);
              } else {
                return AppColors.blueLight;
              }
            },
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icon ?? AppIcons.add,
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
    );
  }
}
