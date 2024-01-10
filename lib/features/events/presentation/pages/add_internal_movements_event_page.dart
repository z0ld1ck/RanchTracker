import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class AddInternalMovementsEventPage extends StatefulWidget {
  const AddInternalMovementsEventPage({super.key});

  @override
  State<AddInternalMovementsEventPage> createState() => _AddInternalMovementsEventPageState();
}

class _AddInternalMovementsEventPageState extends State<AddInternalMovementsEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Внутренние перемещения'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
