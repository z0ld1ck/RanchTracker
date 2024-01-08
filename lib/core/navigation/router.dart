import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/registration_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/page/welcome_page.dart';
import 'package:malshy/features/cattle_list_page/presentation/pages/add_cattle_page.dart';
import 'package:malshy/features/cattle_list_page/presentation/pages/cattle_list_page.dart';
import 'package:malshy/features/cattle_list_page/presentation/pages/filter.dart';
import 'package:malshy/features/dashboard_page/presentation/pages/dashboard_page.dart';
import 'package:malshy/features/events/presentation/pages/events_page.dart';
import 'package:malshy/features/events/presentation/pages/internal_movements_page.dart';
import 'package:malshy/features/events/presentation/pages/loss_page.dart';
import 'package:malshy/features/events/presentation/pages/pregnancy_page.dart';
import 'package:malshy/features/events/presentation/pages/prevention_page.dart';
import 'package:malshy/features/events/presentation/pages/sales_page.dart';
import 'package:malshy/features/events/presentation/pages/slaughter_page.dart';
import 'package:malshy/features/events/presentation/pages/treatment_page.dart';
import 'package:malshy/features/events/presentation/pages/weight_measure_page.dart';
import 'package:malshy/features/map/presentation/pages/map_page.dart';
import 'package:malshy/features/profile/presentation/pages/profile.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    if (AuthStreamScope.of(context).isLoggedIn()) {
      return null;
    } else if (state.fullPath == RouteNames.login.path ||
        state.fullPath == RouteNames.registration.path ||
        state.fullPath == RouteNames.password.path ||
        state.fullPath == RouteNames.sms.path ||
        state.fullPath == RouteNames.welcome.path) {
      return null;
    } else {
      return RouteNames.welcome.path;
    }
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) => RouteNames.dashboard.path,
    ),
    GoRoute(
      path: RouteNames.welcome.path,
      name: RouteNames.welcome.name,
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: RouteNames.registration.path,
      name: RouteNames.registration.name,
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      path: RouteNames.sms.path,
      name: RouteNames.sms.name,
      builder: (context, state) => SMSCodeAuthPage(),
    ),
    GoRoute(
      path: RouteNames.login.path,
      name: RouteNames.login.name,
      builder: (context, state) => LogInPage(),
    ),
    GoRoute(
      path: RouteNames.password.path,
      name: RouteNames.password.name,
      builder: (context, state) => PasswordPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.dashboard.path,
              name: RouteNames.dashboard.name,
              builder: (context, state) => DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.cattleList.path,
              builder: (context, state) => CattleListPage(),
              routes: [
                GoRoute(
                  path: RouteNames.cattleListFilter.path,
                  name: RouteNames.cattleListFilter.name,
                  builder: (context, state) => FilterPage(),
                ),
                GoRoute(
                  path: RouteNames.addCattle.path,
                  name: RouteNames.addCattle.name,
                  builder: (context, state) => AddCattlePage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.events.path,
              name: RouteNames.events.name,
              builder: (context, state) => const EventsPage(),
              routes: [
                GoRoute(
                  path: RouteNames.internalMovements.path,
                  name: RouteNames.internalMovements.name,
                  builder: (context, state) => InternalMovements(),
                ),
                GoRoute(
                  path: RouteNames.prevention.path,
                  name: RouteNames.prevention.name,
                  builder: (context, state) => Prevention(),
                ),
                GoRoute(
                  path: RouteNames.treatment.path,
                  name: RouteNames.treatment.name,
                  builder: (context, state) => Treatment(),
                ),
                GoRoute(
                  path: RouteNames.weight.path,
                  name: RouteNames.weight.name,
                  builder: (context, state) => WeightMeasurement(),
                ),
                GoRoute(
                  path: RouteNames.sales.path,
                  name: RouteNames.sales.name,
                  builder: (context, state) => Sales(),
                ),
                GoRoute(
                  path: RouteNames.slaughter.path,
                  name: RouteNames.slaughter.name,
                  builder: (context, state) => Slaughter(),
                ),
                GoRoute(
                  path: RouteNames.loss.path,
                  name: RouteNames.loss.name,
                  builder: (context, state) => Loss(),
                ),
                GoRoute(
                  path: RouteNames.pregnancy.path,
                  name: RouteNames.pregnancy.name,
                  builder: (context, state) => Pregnancy(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.map.path,
              name: RouteNames.map.name,
              builder: (context, state) => const MapPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.profile.path,
              name: RouteNames.profile.name,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

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
    if (location.startsWith(RouteNames.cattleList.path)) {
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
