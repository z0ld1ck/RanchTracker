import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/routes/global_routes.dart';
import 'package:malshy/core/widgets/add_cattle_button.dart';

class CattleListPage extends StatefulWidget {
  const CattleListPage({super.key});

  @override
  State<CattleListPage> createState() => _CattleListPageState();
}

class _CattleListPageState extends State<CattleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:SvgPicture.asset(AppIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(AppIcons.cow_not_selected),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(AppIcons.notes),
            label: 'Chats',
          ),BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.mark),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.profile),
            label: 'Camera',
          ),
        ],
      ),
      floatingActionButton: AddCattleButton(
        onPressed: () {},
        text: 'Добавить животное',
        icon:SvgPicture.asset('add.svg'),
      ),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: AppBar(
          title: Text('Скот'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              navService.pushNamed(GlobalRoutes.login);
            },
            icon: SvgPicture.asset('back.svg'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                navService.pushNamed(GlobalRoutes.login);
              },
              icon: Icon(Icons.filter_alt),
            ),
          ],
        ),
      ),
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
