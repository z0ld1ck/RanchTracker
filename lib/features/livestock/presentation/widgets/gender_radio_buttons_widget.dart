import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class GenderRadioButtonWidget extends StatefulWidget {
  final ValueNotifier<int> controller;

  const GenderRadioButtonWidget({super.key, required this.controller});

  @override
  _GenderRadioButtonWidgetState createState() =>
      _GenderRadioButtonWidgetState();
}

class _GenderRadioButtonWidgetState extends State<GenderRadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRadioButton('Самка', 0),
        SizedBox(
          width: 8.w,
        ),
        CustomRadioButton('Самец', 1),
      ],
    );
  }

  Widget CustomRadioButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.controller.value = index;
        });
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(69, 32),
        backgroundColor:
        (widget.controller.value == index) ? AppColors.blueLight : AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: (widget.controller.value == index) ? AppColors.blueLight : AppColors.blueLight,
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: (widget.controller.value == index) ? AppColors.white : AppColors.blueLight,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
