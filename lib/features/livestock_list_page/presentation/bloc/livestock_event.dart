part of 'livestock_bloc.dart';

@freezed
class LivestockEvent with _$LivestockEvent {
  const factory LivestockEvent.started() = _Started;
}
