import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:malshy/core/navigation/extra_codec.dart';
import 'package:malshy/core/navigation/route_names.dart';
import 'package:malshy/core/navigation/scaffold_with_nav_bar.dart';
import 'package:malshy/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:malshy/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:malshy/features/auth/presentation/page/log_in_page.dart';
import 'package:malshy/features/auth/presentation/page/password_page.dart';
import 'package:malshy/features/auth/presentation/page/registration_page.dart';
import 'package:malshy/features/auth/presentation/page/sms_code_auth.dart';
import 'package:malshy/features/auth/presentation/page/welcome_page.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';
import 'package:malshy/features/livestock/data/models/livestock_model.dart';
import 'package:malshy/features/livestock/data/models/type_model.dart';
import 'package:malshy/features/livestock/presentation/bloc/add_livestock/add_livestock_bloc.dart';
import 'package:malshy/features/livestock/presentation/bloc/filter_livestock/filter_livestock_bloc.dart';
import 'package:malshy/features/livestock/presentation/pages/add_livestock_page.dart';
import 'package:malshy/features/livestock/presentation/pages/edit_livestock_page.dart';
import 'package:malshy/features/livestock/presentation/pages/livestock_details_page.dart';
import 'package:malshy/features/livestock/presentation/pages/livestock_list_page.dart';
import 'package:malshy/features/livestock/presentation/pages/filter_page.dart';
import 'package:malshy/features/dashboard/presentation/pages/dashboard_page.dart';
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
  extraCodec: const ExtraCodec(),
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
    // welcome page
    GoRoute(
      path: RouteNames.welcome.path,
      name: RouteNames.welcome.name,
      builder: (context, state) => WelcomePage(),
    ),
    // registration
    GoRoute(
      path: RouteNames.registration.path,
      name: RouteNames.registration.name,
      builder: (context, state) => BlocProvider(
        create: (context) => RegistrationBloc(),
        lazy: false,
        child: RegistrationPage(),
      ),
    ),
    // sms
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
    // password
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
    // login
    GoRoute(
      path: RouteNames.login.path,
      name: RouteNames.login.name,
      builder: (context, state) => LogInPage(),
    ),
    // livestockListFilter
    GoRoute(
      path: RouteNames.livestockListFilter.path,
      name: RouteNames.livestockListFilter.name,
      builder: (context, state) {
        return BlocProvider.value(
          value: state.extra! as FilterLivestockBloc,
          child: FilterPage(),
        );
      },
    ),
    // add livestock
    GoRoute(
      path: RouteNames.addLivestock.path,
      name: RouteNames.addLivestock.name,
      builder: (context, state) {
        final isExtra = state.extra != null && state.extra is Map<String, dynamic>;

        final types = isExtra ? (state.extra! as Map<String, dynamic>)['types'] as List<TypeModel> : <TypeModel>[];
        final additionTypes = isExtra
            ? (state.extra! as Map<String, dynamic>)['additionTypes'] as List<AdditionTypeModel>
            : <AdditionTypeModel>[];

        return BlocProvider<AddLivestockBloc>(
          create: (context) => LivestockBloc(),
          child: AddLivestockPage(
            types: types,
            additionTypes: additionTypes,
          ),
        );
      },
    ),
    // livestock details
    GoRoute(
      path: RouteNames.livestockDetails.path,
      name: RouteNames.livestockDetails.name,
      builder: (context, state) {
        // TODO: fix extra
        final isExtra = state.extra != null && state.extra is Map<String, dynamic>;

        final types = isExtra ? (state.extra! as Map<String, dynamic>)['types'] as List<TypeModel> : <TypeModel>[];
        final additionTypes = isExtra
            ? (state.extra! as Map<String, dynamic>)['additionTypes'] as List<AdditionTypeModel>
            : <AdditionTypeModel>[];
        final livestockModel =
            isExtra ? (state.extra! as Map<String, dynamic>)['livestockModel'] as LivestockModel : null;

        return LivestockDetailsPage(
          livestockModel: livestockModel!,
          types: types,
          additionTypes: additionTypes,
        );
      },
    ),
    // edit livestock
    GoRoute(
      path: RouteNames.editLivestock.path,
      name: RouteNames.editLivestock.name,
      builder: (context, state) {
        // TODO: fix extra
        final isExtra = state.extra != null && state.extra is Map<String, dynamic>;

        final types = isExtra ? (state.extra! as Map<String, dynamic>)['types'] as List<TypeModel> : <TypeModel>[];
        final additionTypes = isExtra
            ? (state.extra! as Map<String, dynamic>)['additionTypes'] as List<AdditionTypeModel>
            : <AdditionTypeModel>[];
        final livestockModel =
            isExtra ? (state.extra! as Map<String, dynamic>)['livestockModel'] as LivestockModel : null;

        return BlocProvider<EditLivestockBloc>(
          create: (context) => LivestockBloc(),
          child: EditLivestockPage(
            livestockModel: livestockModel!,
            types: types,
            additionTypes: additionTypes,
          ),
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
              path: RouteNames.livestockList.path,
              builder: (context, state) => BlocProvider(
                create: (context) => FilterLivestockBloc()..add(FilterLivestockEvent.fetchFilters()),
                child: LivestockListPage(),
              ),
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
