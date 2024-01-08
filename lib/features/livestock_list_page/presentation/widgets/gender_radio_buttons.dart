import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class GenderRadioButton extends StatefulWidget {
  const GenderRadioButton({super.key});

  @override
  State<GenderRadioButton> createState() => _GenderRadioButtonState();
}

class _GenderRadioButtonState extends State<GenderRadioButton> {
  int value = 0;

  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            (value == index) ? AppColors.blueLight : AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: (value == index) ? AppColors.blueLight : AppColors.blueLight,
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: (value == index) ? AppColors.white : AppColors.blueLight,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRadioButton('Самка', 1),
        SizedBox(
          width: 8.w,
        ),
        CustomRadioButton('Самец', 2),
      ],
    );
  }
}
