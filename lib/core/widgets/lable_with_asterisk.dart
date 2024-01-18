import 'package:flutter/material.dart';
import 'package:malshy/core/const/app_colors.dart';

class LabelWithAsterisk extends StatelessWidget {
  const LabelWithAsterisk({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          // style: AppTextStyles.caption(context).copyWith(fontSize: 14.sp),
        ),
        Text(
          ' *',
          style: TextStyle(color: AppColors.error),
          // style: AppTextStyles.caption(context).copyWith(fontSize: 18.sp, color: AppColors.error),
        ),
      ],
    );
  }
}
