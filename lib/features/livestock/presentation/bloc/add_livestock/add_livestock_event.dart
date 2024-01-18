part of 'add_livestock_bloc.dart';

@freezed
class LivestockEvent with _$LivestockEvent {
  const factory LivestockEvent.createLivestock({
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

  const factory LivestockEvent.editLivestock({
    required int livestockId,
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
    required List<File> newImages,
    required List<int> deletedImages,
  }) = _EditLivestock;
}
