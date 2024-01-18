part of 'add_livestock_bloc.dart';

enum LivestockStateStatus {
  initial,
  loading,
  error,
  success,
}

@freezed
class LivestockState with _$LivestockState {
  const factory LivestockState({required LivestockStateStatus status}) = _LivestockState;
}
