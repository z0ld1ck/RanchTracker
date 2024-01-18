part of 'add_livestock_bloc.dart';

enum AddLivestockStateStatus {
  initial,
  loading,
  error,
  success,
}

@freezed
class AddLivestockState with _$AddLivestockState {
  const factory AddLivestockState({
    required AddLivestockStateStatus status
  }) = _AddLivestockState;
}
