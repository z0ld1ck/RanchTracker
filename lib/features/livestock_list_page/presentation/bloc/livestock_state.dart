part of 'livestock_bloc.dart';

@freezed
class LivestockState with _$LivestockState {
  const factory LivestockState.initial() = _Initial;

  const factory LivestockState.createLivestockLoading() =
      LivestockLoading;

  const factory LivestockState.livestockFailure(CustomException error) =
      LivestockFailure;

  const factory LivestockState.livestockLoaded() = LivestockLoaded;
}
