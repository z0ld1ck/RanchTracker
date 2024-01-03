import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/features/cattle_list_page/presentation/widgets/dropdown_button.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/const/app_icons.dart';
import '../../../../core/navigation/nav_services.dart';
import '../../../../core/routes/global_routes.dart';
import '../../../../core/widgets/primary_button.dart';

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
            items: [
              DropdownMenuItem(
                value: "Голштинская",
                child: Text("Все породы"),
              ),
              DropdownMenuItem(
                value: "Голш",
                child: Text("Голштинская"),
              ),
              DropdownMenuItem(
                value: "Голш",
                child: Text("Голштинская"),
              ),
              DropdownMenuItem(
                value: 'button',
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.add_blue,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Добавить новую породу',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.blueLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                value: "Все весы",
                child: Text("Все массы"),
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
                value: "AllAges",
                child: Text("Все возрасты"),
              ),
              DropdownMenuItem(
                value: "SingleAge",
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
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 350.h,
          ),
          PrimaryButton(
            text: 'Сохранить',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
