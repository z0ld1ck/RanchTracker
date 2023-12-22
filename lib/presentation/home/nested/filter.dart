import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/services/shared_pref.dart';
import 'package:malshy/core/widgets/dropdown_button.dart';

import '../../../core/const/app_icons.dart';
import '../../../core/navigation/nav_services.dart';
import '../../../core/routes/global_routes.dart';
import '../../../core/widgets/primary_button.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Фильтрация списка'),
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
            height: 32.h,
          ),
          DropDownFilter(
            label: 'Все виды',
            items: const [
              DropdownMenuItem(
                value: "КРС",
                child: Text("КРС"),
              ),
              DropdownMenuItem(
                value: "МРС",
                child: Text("МРС"),
              ),
              DropdownMenuItem(
                value: "Лошади",
                child: Text("Лошади"),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          DropDownFilter(
            label: 'Породы',
            items: const [
              DropdownMenuItem(
                value: "Голштинская",
                child: Text("Голштинская"),
              ),
              DropdownMenuItem(
                value: "Немецкая",
                child: Text("Немецкая"),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          DropDownFilter(
            label: 'Масса',
            items: const [
              DropdownMenuItem(
                value: "Все массы",
                child: Text("Все массы"),
              ),
              DropdownMenuItem(
                value: "Масса",
                child: Text("Масса"),
              ),
            ],
          ),
          SizedBox(
            height: 17.h,
          ),
          DropDownFilter(
            label: 'Полновозрастные группы',
            items: const [
              DropdownMenuItem(
                value: "Все возрасты",
                child: Text("Все возрасты"),
              ),
              DropdownMenuItem(
                value: "Возраст",
                child: Text("Возраст"),
              ),
            ],
          ),
          SizedBox(
            height: 17.h,
          ),
          DropDownFilter(
            label: 'Стельность',
            items: const [
              DropdownMenuItem(
                value: "Стельны и не стельны",
                child: Text("Стельны и не стельны"),
              ),
              DropdownMenuItem(
                value: "Не стельны и стельны",
                child: Text("Не стельны и стельны"),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 350.h,
          ),
          PrimaryButton(
            text:'Сохранить',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
