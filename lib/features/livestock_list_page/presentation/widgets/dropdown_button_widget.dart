import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class DropdownFilterWidget extends StatefulWidget {
  const DropdownFilterWidget({super.key, required this.label, required this.items, required this.hint});

  final String hint;
  final String label;
  final List<DropdownMenuItem<String>> items;

  @override
  State<DropdownFilterWidget> createState() => _DropdownFilterWidgetState();
}

class _DropdownFilterWidgetState extends State<DropdownFilterWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField(
        hint: Text(widget.hint),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
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
              style: TextStyle(color: Colors.black),
            );
          }).toList();
        },
      ),
    );
  }
}
