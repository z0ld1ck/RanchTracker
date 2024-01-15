part of 'add_livestock_bloc.dart';

@freezed
class AddLivestockState with _$AddLivestockState {
  const factory AddLivestockState.initial() = _Initial;

  const factory AddLivestockState.createLivestockLoading() = LivestockLoading;

  const factory AddLivestockState.livestockFailure(CustomException error) = LivestockFailure;

  const factory AddLivestockState.livestockLoaded() = LivestockLoaded;
}
