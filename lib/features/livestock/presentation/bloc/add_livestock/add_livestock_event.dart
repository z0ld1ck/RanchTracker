part of 'add_livestock_bloc.dart';

@freezed
class AddLivestockEvent with _$AddLivestockEvent {
  const factory AddLivestockEvent.createLivestock({
    required String rfid,
    required String? nickname,
    required DateTime birthday,
    required int type,
    required int breed,
    required int sex,
    required int age,
    required double weight,
    required int additionMethod,
    required String? motherRfid,
    required String? fatherRfid,
    required List<File> images,
  }) = _CreateLivestock;
}
