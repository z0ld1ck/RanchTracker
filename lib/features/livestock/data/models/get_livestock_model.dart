import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_livestock_model.freezed.dart';
part 'get_livestock_model.g.dart';

List<GetLivestockModel> getLivestockModelFromJson(String str) =>
    List<GetLivestockModel>.from(json.decode(str).map((x) => GetLivestockModel.fromJson(x)));

String getLivestockModelToJson(List<GetLivestockModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class GetLivestockModel with _$GetLivestockModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetLivestockModel({
    required DateTime? createdAt,
    required int? id,
    required String? rfid,
    required String? nickname,
    required DateTime? birthday,
    required LocalizedString? type,
    required String? breed,
    required int? sex,
    required int? age,
    required double? weight,
    required int? additionMethod,
    required String? motherRfid,
    required String? fatherRfid,
    required int? farmId,
    required dynamic photo,
    required LocalizedString? status,
  }) = _GetLivestockModel;

  factory GetLivestockModel.fromJson(Map<String, dynamic> json) => _$GetLivestockModelFromJson(json);
}

@freezed
class LocalizedString with _$LocalizedString {
  const factory LocalizedString({
    required String en,
    required String ru,
    required String kz,
  }) = _LocalizedString;

  factory LocalizedString.fromJson(Map<String, dynamic> json) => _$LocalizedStringFromJson(json);
}
