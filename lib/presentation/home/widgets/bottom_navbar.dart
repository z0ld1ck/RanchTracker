import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/presentation/home/pages/dashboard_page.dart';
import 'package:malshy/presentation/home/widgets/menuItem.dart';
import '../../../core/const/app_icons.dart';
import '../pages/cattle_list_page.dart';
import 'package:malshy/presentation/home/pages/events_page.dart';

import '../pages/map_page.dart';
import '../pages/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  void onTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final bottomNavigationBarItems = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      items: bottomNavigationBarItems,
      onTap: onTap,
      selectedItemColor: AppColors.blueLight,
    );
  }
}
