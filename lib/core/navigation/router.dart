import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/const/app_colors.dart';
import 'package:malshy/core/const/app_icons.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:malshy/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/registration_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/page/welcome_page.dart';
import 'package:malshy/features/livestock_list_page/presentation/bloc/filter_livestock/filter_livestock_bloc.dart';
import 'package:malshy/features/livestock_list_page/presentation/pages/add_cattle_page.dart';
import 'package:malshy/features/livestock_list_page/presentation/pages/cattle_list_page.dart';
import 'package:malshy/features/livestock_list_page/presentation/pages/filter_page.dart';
import 'package:malshy/features/dashboard_page/presentation/pages/dashboard_page.dart';
import 'package:malshy/features/events/presentation/pages/events_page.dart';
import 'package:malshy/features/events/presentation/pages/add_internal_movements_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_loss_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_pregnancy_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_prevention_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_sales_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_slaughter_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_treatment_event_page.dart';
import 'package:malshy/features/events/presentation/pages/add_weight_measure_event_page.dart';
import 'package:malshy/features/map/presentation/pages/map_page.dart';
import 'package:malshy/features/profile/presentation/pages/profile_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter goRouter = GoRouter(
  extraCodec: const MyExtraCodec(),
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    final authGlobalState = AuthStreamScope.of(context).authGlobalState();
    final loggedIn = authGlobalState == AuthGlobalState.authenticated;
    final loggingIn = state.fullPath == RouteNames.login.path ||
        state.fullPath == RouteNames.registration.path ||
        state.fullPath == RouteNames.password.path ||
        state.fullPath == RouteNames.sms.path ||
        state.fullPath == RouteNames.welcome.path;

    if (!loggedIn) return loggingIn ? null : RouteNames.welcome.path;

    if (loggingIn) return RouteNames.dashboard.path;

    return null;
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
      builder: (context, state) => BlocProvider(
        create: (context) => RegistrationBloc(),
        lazy: false,
        child: RegistrationPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.sms.path,
      name: RouteNames.sms.name,
      builder: (context, state) {
        return BlocProvider.value(
          value: state.extra! as RegistrationBloc,
          child: SMSCodeAuthPage(),
        );
      },
    ),
    GoRoute(
      path: RouteNames.password.path,
      name: RouteNames.password.name,
      builder: (context, state) {
        return BlocProvider.value(
          value: state.extra! as RegistrationBloc,
          child: PasswordPage(),
        );
      },
    ),
    GoRoute(
      path: RouteNames.login.path,
      name: RouteNames.login.name,
      builder: (context, state) => LogInPage(),
    ),
    GoRoute(
      path: RouteNames.cattleListFilter.path,
      name: RouteNames.cattleListFilter.name,
      builder: (context, state) {
        return BlocProvider.value(
          value: state.extra! as FilterLivestockBloc,
          child: FilterPage(),
        );
      },
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
              builder: (context, state) => BlocProvider(
                create: (context) => FilterLivestockBloc()..add(FilterLivestockEvent.fetchFilters()),
                child: CattleListPage(),
              ),
              routes: [
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
                  builder: (context, state) => AddInternalMovementsEventPage(),
                ),
                GoRoute(
                  path: RouteNames.prevention.path,
                  name: RouteNames.prevention.name,
                  builder: (context, state) => AddPreventionEventPage(),
                ),
                GoRoute(
                  path: RouteNames.treatment.path,
                  name: RouteNames.treatment.name,
                  builder: (context, state) => AddTreatmentEventPage(),
                ),
                GoRoute(
                  path: RouteNames.weight.path,
                  name: RouteNames.weight.name,
                  builder: (context, state) => AddWeightMeasurementEventPage(),
                ),
                GoRoute(
                  path: RouteNames.sales.path,
                  name: RouteNames.sales.name,
                  builder: (context, state) => AddSalesEventPage(),
                ),
                GoRoute(
                  path: RouteNames.slaughter.path,
                  name: RouteNames.slaughter.name,
                  builder: (context, state) => AddSlaughterEventPage(),
                ),
                GoRoute(
                  path: RouteNames.loss.path,
                  name: RouteNames.loss.name,
                  builder: (context, state) => AddLossPage(),
                ),
                GoRoute(
                  path: RouteNames.pregnancy.path,
                  name: RouteNames.pregnancy.name,
                  builder: (context, state) => AddPregnancyEventPage(),
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

// write codec for RegistrationBloc

/// A codec that can serialize both [RegistrationBloc].
class MyExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const MyExtraCodec();
  @override
  Converter<Object?, Object?> get decoder => const _MyExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _MyExtraEncoder();
}

class _MyExtraDecoder extends Converter<Object?, Object?> {
  const _MyExtraDecoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final List<Object?> inputAsList = input as List<Object?>;
    if (inputAsList[0] == 'RegistrationBloc') {
      return inputAsList[1];
    }
    if (inputAsList[0] == 'FilterLivestockBloc') {
      return inputAsList[1];
    }
    throw FormatException('Unable to parse input: $input');
  }
}

class _MyExtraEncoder extends Converter<Object?, Object?> {
  const _MyExtraEncoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    switch (input) {
      case RegistrationBloc _:
        return <Object?>['RegistrationBloc', input];
      case FilterLivestockBloc _:
        return <Object?>['FilterLivestockBloc', input];
      default:
        throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
