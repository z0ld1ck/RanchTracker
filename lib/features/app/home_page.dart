import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/features/cattle_list_page/presentation/pages/cattle_list_page.dart';
import 'package:malshy/features/dashboard_page/presentation/pages/dashboard_page.dart';
import 'package:malshy/features/map/presentation/pages/map_page.dart';
import 'package:malshy/features/profile/presentation/pages/profile.dart';
import '../events/presentation/pages/events_page.dart';
import '../../core/const/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          DashboardPage(),
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
            activeIcon: SvgPicture.asset(AppIcons.dash),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.cow_not_selected),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.cow_svet),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.notes),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.notes2),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.mark),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.map),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.profile),
            label: '',
            activeIcon: SvgPicture.asset(AppIcons.account),
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
      ),
    );
  }

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
