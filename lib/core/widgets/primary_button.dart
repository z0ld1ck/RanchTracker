import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.color,
    required this.onPressed,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.child,
    this.elevation,
    this.text,
  });

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
      width: double.infinity,
      child: MaterialButton(
        elevation: elevation,
        color: color ?? AppColors.primary(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              text ?? '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
      ),
    );
  }
}
