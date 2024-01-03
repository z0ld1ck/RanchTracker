import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/app/app.dart';
import '../../../../core/const/app_icons.dart';
import '../../../../core/navigation/nav_services.dart';
import '../../../../core/routes/global_routes.dart';

class AddCattlePage extends StatefulWidget {
  const AddCattlePage({super.key});

  @override
  State<AddCattlePage> createState() => _AddCattlePageState();
}

class _AddCattlePageState extends State<AddCattlePage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Добавить животное'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              navService.pushNamed(GlobalRoutes.nav);
            },
            icon: SvgPicture.asset(AppIcons.back),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: SvgPicture.asset(AppIcons.avatar),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            width: 325.w,
            height: 48.h,
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Ушная бирка(RFD)*',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                hintText: 'Введите ушную бирку',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayMedium,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          SizedBox(
            width: 325.w,
            height: 48.h,
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Ушная бирка(RFD)*',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                hintText: 'Введите ушную бирку',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayMedium,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          SizedBox(
            width: 325.w,
            height: 48.h,
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(AppIcons.date),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        date = selectedDate;
                      });
                    }
                  },
                ),
                labelText: 'Ушная бирка(RFD)*',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                hintText: 'Введите ушную бирку',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.grayMedium,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          // DropdownButtonFormField(items: [], onChanged:(){})
        ],
      ),
    );
  }
}
