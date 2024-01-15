import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:malshy/core/utils/data_state.dart';
import 'package:malshy/features/dashboard/data/models/dashboard_by_action_model.dart';
import 'package:malshy/features/dashboard/data/models/dashboard_by_status_model.dart';
import 'package:malshy/features/dashboard/data/models/dashboard_by_type_model.dart';
import 'package:malshy/features/dashboard/domain/usecase/get_dashboard_by_action_usecase.dart';
import 'package:malshy/features/dashboard/domain/usecase/get_dashboard_by_status_usecase.dart';
import 'package:malshy/features/dashboard/domain/usecase/get_dashboard_by_type_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

mixin DashboardByStatusBloc on Bloc<DashboardEvent, DashboardState> {}

mixin DashboardByTypeBloc on Bloc<DashboardEvent, DashboardState> {}

mixin DashboardByActionBloc on Bloc<DashboardEvent, DashboardState> {}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState>
    with DashboardByStatusBloc, DashboardByTypeBloc, DashboardByActionBloc {
  final _getDashboardByTypeUsecase = GetIt.I.get<GetDashboardByTypeUsecase>();
  final _getDashboardByStatusUsecase = GetIt.I.get<GetDashboardByStatusUsecase>();
  final _getDashboardByActionUsecase = GetIt.I.get<GetDashboardByActionUsecase>();

  DashboardBloc()
      : super(DashboardState(
          status: DashboardStateStatus.loading,
          byStatus: null,
          byType: null,
          byAction: null,
        )) {
    on<LoadByType>(_loadByType);
    on<LoadByStatus>(_loadByStatus);
    on<LoadByAction>(_loadByAction);
  }

  Future<void> _loadByType(LoadByType event, emit) async {
    emit(state.copyWith(status: DashboardStateStatus.loading));
    final result = await _getDashboardByTypeUsecase();

    if (result is DataSuccess) {
      emit(DashboardState(
        status:
            result.data != null && result.data!.isNotEmpty ? DashboardStateStatus.success : DashboardStateStatus.empty,
        byType: result.data,
        byStatus: null,
        byAction: null,
      ));
    }
    if (result is DataFailed) {
      emit(DashboardState(
        status: DashboardStateStatus.error,
        byType: null,
        byStatus: null,
        byAction: null,
      ));
    }
  }

  Future<void> _loadByStatus(LoadByStatus event, emit) async {
    emit(state.copyWith(status: DashboardStateStatus.loading));
    final result = await _getDashboardByStatusUsecase();

    if (result is DataSuccess) {
      emit(DashboardState(
        status:
            result.data != null && result.data!.isNotEmpty ? DashboardStateStatus.success : DashboardStateStatus.empty,
        byStatus: result.data,
        byType: null,
        byAction: null,
      ));
    }
    if (result is DataFailed) {
      emit(DashboardState(
        status: DashboardStateStatus.error,
        byType: null,
        byStatus: null,
        byAction: null,
      ));
    }
  }

  Future<void> _loadByAction(LoadByAction event, emit) async {
    emit(state.copyWith(status: DashboardStateStatus.loading));
    final result = await _getDashboardByActionUsecase();

    if (result is DataSuccess) {
      emit(DashboardState(
        status: result.data != null ? DashboardStateStatus.success : DashboardStateStatus.empty,
        byAction: result.data,
        byType: null,
        byStatus: null,
      ));
    }
    if (result is DataFailed) {
      emit(DashboardState(
        status: DashboardStateStatus.error,
        byType: null,
        byStatus: null,
        byAction: null,
      ));
    }
  }
}
