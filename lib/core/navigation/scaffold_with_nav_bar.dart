import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
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
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(RouteNames.dashboard.path)) {
      return 0;
    }
    if (location.startsWith(RouteNames.livestockList.path)) {
      return 1;
    }
    if (location.startsWith(RouteNames.events.path)) {
      return 2;
    }
    if (location.startsWith(RouteNames.map.path)) {
      return 3;
    }
    if (location.startsWith(RouteNames.profile.path)) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
