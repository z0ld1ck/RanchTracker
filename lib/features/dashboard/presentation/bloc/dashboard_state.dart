part of 'dashboard_bloc.dart';

enum DashboardStateStatus {
  loading,
  error,
  empty,
  success,
}

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    required DashboardStateStatus status,
    required List<DashboardByStatusModel>? byStatus,
    required List<DashboardByTypeModel>? byType,
    required DashboardByActionModel? byAction,
  }) = _DashboardState;
}
