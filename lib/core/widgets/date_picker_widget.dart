import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/function/date_formatter.dart';

import 'lable_with_asterisk.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    required this.isRequired,
    required this.label,
    required this.hint,
    required this.isDatePicker,
    this.isTimePicker,
    required this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    required this.firstDate,
    required this.lastDate,
    this.onTap,
    this.value,
    this.validationKey,
  });

  final TextEditingController? controller;
  final String? value;
  final bool isRequired;
  final GlobalKey<FormFieldState>? validationKey;
  final String label;
  final String hint;
  final bool isDatePicker;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool? isTimePicker;
  final String? prefixIcon;
  final Color? prefixIconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ??
          ((value != null && value!.isNotEmpty)
              ? TextEditingController(text: value)
              : null),
      readOnly: isDatePicker,
      enabled: true,
      key: validationKey,
      autovalidateMode: value != null
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      validator: isRequired
          ? controller != null
              ? (value) {
        return '';
                  // return (value == null || (value != null && value.isEmpty))
                  //     // ? `AppLocalizations.of(context)!
                  //     //     .fieldCannotBeEmpty
                  //     //     .capitalize()`
                  //     : null;
                }
              : (_) {
                  return '';
                    // (value == null || (value != null && value!.isEmpty))
                    //   ? AppLocalizations.of(context)!
                    //       .fieldCannotBeEmpty
                    //       .capitalize()
                    //   : null;
                }
          : null,
      onTap: onTap ??
          () async {
            if (isDatePicker) {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: firstDate,
                lastDate: lastDate,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      useMaterial3: false,
                      applyElevationOverlayColor: false,
                    ),
                    child: child!,
                  );
                },
              );

              if (date != null) controller?.text = date.toDateTimeWithDots();

              if (date != null &&
                  isTimePicker != null &&
                  isTimePicker! &&
                  context.mounted) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        useMaterial3: false,
                        applyElevationOverlayColor: false,
                      ),
                      child: child!,
                    );
                  },
                );

                if (time != null && context.mounted)
                  controller?.text +=
                      ' ${time.format(context).padLeft(5, '0')}';
              }
            }
          },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.all(8.w),
                child: Image.asset(
                  prefixIcon!,
                  width: 20,
                  height: 20,
                  color: prefixIconColor,
                ),
              )
            : null,
        suffixIcon:SvgPicture.asset(AppIcons.date),
        suffixIconConstraints: BoxConstraints(
          minHeight: 24,
          minWidth: 52
        ),
        label: isRequired ? LabelWithAsterisk(label: label) : Text(label),
        hintText: value != null && value!.isNotEmpty ? value : hint,
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: value != null && value!.isNotEmpty
                  ? Theme.of(context).textTheme.labelLarge!.color
                  : null,
            ),
      ),
    );
  }
}
