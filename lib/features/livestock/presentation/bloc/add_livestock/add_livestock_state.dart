part of 'add_livestock_bloc.dart';

enum AddLivestockStateStatus {
  loading,
  error,
  success,
}

@freezed
class AddLivestockState with _$AddLivestockState {
  const factory AddLivestockState({
    required AddLivestockStateStatus status,
    final  List<TypeModel>types,
  }) = _AddLivestockState;
}
