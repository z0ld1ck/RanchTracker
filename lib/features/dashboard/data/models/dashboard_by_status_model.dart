import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:malshy/features/livestock/data/models/get_livestock_model.dart';

part 'dashboard_by_status_model.freezed.dart';
part 'dashboard_by_status_model.g.dart';

List<DashboardByStatusModel> dashboardByStatusModelFromJson(String str) =>
    List<DashboardByStatusModel>.from(json.decode(str).map((x) => DashboardByStatusModel.fromJson(x)));

String dashboardByStatusModelToJson(List<DashboardByStatusModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class DashboardByStatusModel with _$DashboardByStatusModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DashboardByStatusModel({
    required LocalizedString status,
    required int count,
  }) = _DashboardByStatusModel;

  factory DashboardByStatusModel.fromJson(Map<String, dynamic> json) => _$DashboardByStatusModelFromJson(json);
}
