part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.loadByType() = LoadByType;

  const factory DashboardEvent.loadByAction() = LoadByAction;

  const factory DashboardEvent.loadByStatus() = LoadByStatus;
}