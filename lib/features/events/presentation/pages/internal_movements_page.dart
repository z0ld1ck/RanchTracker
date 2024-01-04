import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malshy/core/const/app_colors.dart';

class InternalMovements extends StatefulWidget {
  const InternalMovements({super.key});

  @override
  State<InternalMovements> createState() => _InternalMovementsState();
}

class _InternalMovementsState extends State<InternalMovements> {
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
        children: [

        ],
      ),
    );
  }
}
