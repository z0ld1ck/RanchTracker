import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/presentation/home/pages/profile.dart';

import '../../../core/const/app_icons.dart';
import 'cattle_list_page.dart';
import 'map_page.dart';
import 'events_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          SizedBox(height: 26.h),
          TextField(
            decoration: InputDecoration(
              hintText: 'Поиск животных по ушной бирке и имени',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            ),
          ),
          SizedBox(
            height: 300.h,
          ),
          Center(
            child: Text('Список пуст'),
          ),
        ],
      ),
    );
  }
}
