import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/models/localized_string_model.dart';
import 'dart:convert';

part 'type_model.freezed.dart';
part 'type_model.g.dart';

List<TypeModel> typeFromJson(String str) => List<TypeModel>.from(json.decode(str).map((x) => TypeModel.fromJson(x)));

String typeToJson(List<TypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class TypeModel with _$TypeModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TypeModel({
    required LocalizedString name,
    required int type,
    required List<BreedModel> breeds,
  }) = _TypeModel;

  factory TypeModel.fromJson(Map<String, dynamic> json) => _$TypeModelFromJson(json);
}


@freezed
class BreedModel with _$BreedModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BreedModel({
    required DateTime? createdAt,
    required int id,
    required int projectId,
    required String breed,
    required int livestockType,
  }) = _BreedModel;

  factory BreedModel.fromJson(Map<String, dynamic> json) => _$BreedModelFromJson(json);
}
