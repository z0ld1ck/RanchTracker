import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/function/date_formatter.dart';

import 'lable_with_asterisk.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    super.key,
    required this.dateValue,
    required this.isRequired,
    required this.label,
    required this.hint,
    required this.firstDate,
    required this.lastDate,
  });

  final bool isRequired;
  final String label;
  final String hint;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueNotifier<DateTime?> dateValue;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final GlobalKey<FormFieldState> _validationKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:
          widget.dateValue.value != null ? TextEditingController(text: widget.dateValue.value!.toDateWithDots()) : null,
      readOnly: true,
      enabled: true,
      key: _validationKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.isRequired
          ? (_) {
              return widget.dateValue.value == null ? 'fieldCannotBeEmpty' : null;
            }
          : null,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.dateValue.value,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
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

        if (date != null) widget.dateValue.value = date;
        _validationKey.currentState?.validate();
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: SvgPicture.asset(
          AppIcons.date,
          color: widget.dateValue.value != null ? Colors.black : null,
          height: 24.h,
          width: 24.h,
        ).paddingOnly(right: 12.w),
        suffixIconConstraints: BoxConstraints(
          minHeight: 24.h, minWidth: 24.h
        ),
        label: widget.isRequired ? LabelWithAsterisk(label: widget.label) : Text(widget.label),
        hintText: widget.hint,
      ),
    );
  }
}
