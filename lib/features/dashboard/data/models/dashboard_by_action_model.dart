import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'dashboard_by_action_model.freezed.dart';
part 'dashboard_by_action_model.g.dart';

DashboardByActionModel dashboardByActionModelFromJson(String str) => DashboardByActionModel.fromJson(json.decode(str));

String dashboardByActionModelToJson(DashboardByActionModel data) => json.encode(data.toJson());

@freezed
class DashboardByActionModel with _$DashboardByActionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DashboardByActionModel({
    required int sales,
    required int buy,
    required int born,
    required int dead,
    required int slaughter,
    required int lost,
    required int toIsolation,
    required int fromIsolation,
  }) = _DashboardByActionModel;

  factory DashboardByActionModel.fromJson(Map<String, dynamic> json) => _$DashboardByActionModelFromJson(json);
}
