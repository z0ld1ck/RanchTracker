import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_string_model.freezed.dart';
part 'localized_string_model.g.dart';


@freezed
class LocalizedString with _$LocalizedString {
  const factory LocalizedString({
    required String en,
    required String ru,
    required String kz,
  }) = _LocalizedString;

  factory LocalizedString.fromJson(Map<String, dynamic> json) => _$LocalizedStringFromJson(json);
}
