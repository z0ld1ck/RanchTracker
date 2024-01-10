import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/app_icons.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/dropdown_button_widget.dart';

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
              context.pop();
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
          DropdownFilterWidget(
            hint:'Все виды',
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
          DropdownFilterWidget(
            hint:'Все породы',
            label: 'Породы',
            items: [
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
          DropdownFilterWidget(
            hint:'Все массы',
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
          DropdownFilterWidget(
            hint:'Все возрасты',
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
          DropdownFilterWidget(
            hint:'Стельны и не стельны',
            label: 'Стельность',
            items: const [
              DropdownMenuItem(
                value: "Стельны",
                child: Text("Стельны"),
              ), DropdownMenuItem(
                value: " Не стельны",
                child: Text("Не стельны"),
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
