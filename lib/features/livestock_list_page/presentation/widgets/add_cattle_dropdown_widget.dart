import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class AddCattleDropDown extends StatefulWidget {
  const AddCattleDropDown(
      {super.key,
      required this.label,
      required this.items,
      required this.hint});

  final String label;
  final String hint;
  final List<DropdownMenuItem<String>> items;

  @override
  State<AddCattleDropDown> createState() => _AddCattleDropDownState();
}

class _AddCattleDropDownState extends State<AddCattleDropDown> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: DropdownButtonFormField(
        hint: Text(widget.hint),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        value: selectedValue,
        items: widget.items,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        style: TextStyle(color: Colors.black),
        selectedItemBuilder: (BuildContext context) {
          return widget.items.map<Widget>((DropdownMenuItem<String> item) {
            return Text(
              item.value!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                  ),
            );
          }).toList();
        },
      ),
    );
  }
}