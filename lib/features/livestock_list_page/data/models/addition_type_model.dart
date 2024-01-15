import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/models/localized_string_model.dart';

part 'addition_type_model.freezed.dart';

part 'addition_type_model.g.dart';

@freezed
class AdditionTypeModel with _$AdditionTypeModel {
  const factory AdditionTypeModel({
    required LocalizedString name,
    required int type,
  }) = _AdditionTypeModel;

  factory AdditionTypeModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionTypeModelFromJson(json);
}
