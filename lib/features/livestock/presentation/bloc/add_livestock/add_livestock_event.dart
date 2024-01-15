part of 'add_livestock_bloc.dart';

@freezed
class AddLivestockEvent with _$AddLivestockEvent {
  const factory AddLivestockEvent.createLivestock()=CreateLivestock;
  const factory AddLivestockEvent.getTypeAndBreed() =GetTypeAndBreed;
  const factory AddLivestockEvent.getAdditionType() =GetAdditionType;

}
