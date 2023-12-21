import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/nav_services.dart';
import 'package:malshy/core/routes/global_routes.dart';
import 'package:malshy/core/widgets/add_cattle_button.dart';
import 'package:malshy/presentation/home/pages/dashboard_page.dart';
import 'package:malshy/presentation/home/pages/map_page.dart';
import 'package:malshy/presentation/home/pages/profile.dart';
import '../widgets/bottom_navbar.dart';
import 'events_page.dart';

class CattleListPage extends StatefulWidget {
  CattleListPage({Key? key}) : super(key: key);

  @override
  State<CattleListPage> createState() => _CattleListPageState();
}

class _CattleListPageState extends State<CattleListPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Dashboard(),
    CattleListPage(),
    Events(),
    MapPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCattleButton(
        onPressed: () {},
        text: 'Добавить животное',
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
            icon: SvgPicture.asset(AppIcons.back),
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
      bottomNavigationBar: BottomBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
