import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/presentation/home/pages/cattle_list_page.dart';
import 'package:malshy/presentation/home/pages/dashboard_page.dart';
import 'package:malshy/presentation/home/pages/map_page.dart';
import 'package:malshy/presentation/home/pages/profile.dart';
import 'events_page.dart';
import '../../../core/const/app_icons.dart';
import '../../../core/navigation/nav_services.dart';
import '../../../core/routes/global_routes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: IndexedStack(
        index: currentIndex,
        children: [
          Dashboard(),
          CattleListPage(),
          Events(),
          MapPage(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.home),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.dashboard_selected),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.cow_not_selected),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.cow_selected),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.notes),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.notes_selected),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.mark),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.map_selected),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.profile),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.profile_selected),
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
