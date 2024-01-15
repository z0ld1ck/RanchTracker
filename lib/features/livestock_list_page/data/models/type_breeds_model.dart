import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_breeds_model.freezed.dart';

part 'type_breeds_model.g.dart';

@freezed
class TypeBreedsModel with _$TypeBreedsModel {
  const factory TypeBreedsModel({
    required Map<String, String> name,
    required int type,
    required List<String> breeds,
  }) = _TypeBreedsModel;

  factory TypeBreedsModel.fromJson(Map<String, dynamic> json) =>
      _$TypeBreedsModelFromJson(json);
}

