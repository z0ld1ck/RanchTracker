import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/core/models/localized_string_model.dart';
import 'dart:convert';

part 'dashboard_by_type_model.freezed.dart';
part 'dashboard_by_type_model.g.dart';

List<DashboardByTypeModel> dashboardByTypeModelFromJson(String str) =>
    List<DashboardByTypeModel>.from(json.decode(str).map((x) => DashboardByTypeModel.fromJson(x)));

String dashboardByTypeModelToJson(List<DashboardByTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class DashboardByTypeModel with _$DashboardByTypeModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DashboardByTypeModel({
    required LocalizedString type,
    required int count,
  }) = _DashboardByTypeModel;

  factory DashboardByTypeModel.fromJson(Map<String, dynamic> json) => _$DashboardByTypeModelFromJson(json);
}
