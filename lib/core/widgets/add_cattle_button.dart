import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  final Widget? icon;
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
      width: 169.w,
      height: 38.h,
      child: MaterialButton(
        elevation: elevation,
        color: color ?? AppColors.blueLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Row(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 4.w),
                Text(
                  text ?? '',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
