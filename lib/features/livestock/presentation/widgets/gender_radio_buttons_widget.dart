import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class GenderRadioButtonWidget extends StatelessWidget {
  final ValueNotifier<int> controller;

  const GenderRadioButtonWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _customRadioButton(context, 'Самка', 0),
        SizedBox(width: 8.w),
        _customRadioButton(context, 'Самец', 1),
      ],
    );
  }

  Widget _customRadioButton(BuildContext context, String text, int index) {
    return ElevatedButton(
      onPressed: () {
        controller.value = index;
      },
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        backgroundColor:
          (controller.value == index) ? AppColors.primary(context) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.r),
          side: BorderSide(
            color: AppColors.primary(context),
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: (controller.value == index) ? AppColors.white : AppColors.primary(context),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
