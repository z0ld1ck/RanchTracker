import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/function/date_formatter.dart';
import 'package:malshy/core/models/localized_string_model.dart';
import 'package:malshy/features/livestock/domain/entities/livestock_entity.dart';

part 'get_livestock_model.freezed.dart';
part 'get_livestock_model.g.dart';

List<LivestockModel> livestockModelListFromJson(String str) =>
    List<LivestockModel>.from(json.decode(str).map((x) => LivestockModel.fromJson(x)));

@unfreezed
class LivestockModel with _$LivestockModel {
  LivestockModel._();
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory LivestockModel({
    required DateTime? createdAt,
    required int id,
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
    required int farmId,
    required List<Photo> photos,
    required LocalizedString? status,
  }) = _LivestockModel;

  factory LivestockModel.fromJson(Map<String, dynamic> json) => _$LivestockModelFromJson(json);

  LivestockEntity toEntity() {
    return LivestockEntity(
      createdAt: createdAt?.toString(),
      id: id,
      rfid: rfid,
      nickname: nickname,
      birthday: birthday.toString(),
      type: type,
      breed: breed,
      sex: sex,
      age: age,
      weight: weight,
      additionMethod: additionMethod,
      motherRfid: motherRfid,
      fatherRfid: fatherRfid,
      farmId: farmId,
      // TODO: посмотреть что с фотками в Entity
      photo: jsonEncode(photos),
      status: jsonEncode(status),
    );
  }

  Map<String, dynamic> toApiJson() {
    Map<String, dynamic> body = {
      'rfid': rfid,
      'birthday': birthday.toApiDateFormat(),
      'type': type,
      'breed': breed,
      'addition_method': additionMethod,
      'weight': weight,
      'sex': sex,
      'age': age,
      'farm_id': farmId,
    };

    if (nickname != null) body['nickname'] = nickname;
    if (motherRfid != null) body['mother_rfid'] = motherRfid;
    if (fatherRfid != null) body['father_rfid'] = fatherRfid;
    return body;
  }
}

@freezed
class Photo with _$Photo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Photo({
    required int id,
    required int livestockId,
    required String photo,
  }) = _Photo;
  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
