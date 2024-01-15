part of 'livestock_bloc.dart';

@freezed
class LivestockEvent with _$LivestockEvent {
  const factory LivestockEvent.createLivestock()=CreateLivestock;
  const factory LivestockEvent.getTypeAndBreed() =GetTypeAndBreed;
  const factory LivestockEvent.getAdditionType() =GetAdditionType;

}
