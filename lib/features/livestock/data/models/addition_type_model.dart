import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/models/localized_string_model.dart';

part 'addition_type_model.freezed.dart';

part 'addition_type_model.g.dart';

List<AdditionTypeModel> additionTypeModelFromJson(String str) => List<AdditionTypeModel>.from(json.decode(str).map((x) => AdditionTypeModel.fromJson(x)));

String additionTypeModelToJson(List<AdditionTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class AdditionTypeModel with _$AdditionTypeModel {
  const factory AdditionTypeModel({
    required LocalizedString name,
    required int type,
  }) = _AdditionTypeModel;

  factory AdditionTypeModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionTypeModelFromJson(json);
}
