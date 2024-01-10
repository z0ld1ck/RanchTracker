part of 'livestock_bloc.dart';

@freezed
class LivestockState with _$LivestockState {
  const factory LivestockState.initial() = _Initial;

  const factory LivestockState.createLivestockLoading() =
      CreateLivestockLoading;

  const factory LivestockState.createLivestockFailure(CustomException error) =
      CreateLivestockFailure;

  const factory LivestockState.livestockCreated() = LivestockCreated;
}
