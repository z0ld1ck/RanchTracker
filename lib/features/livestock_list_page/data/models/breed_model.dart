import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed_model.freezed.dart';
part 'breed_model.g.dart';

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
