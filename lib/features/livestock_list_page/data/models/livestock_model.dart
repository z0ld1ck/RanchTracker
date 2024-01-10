import 'package:freezed_annotation/freezed_annotation.dart';

part 'livestock_model.freezed.dart';
part 'livestock_model.g.dart';

@freezed
class LivestockModel with _$LivestockModel{
   factory LivestockModel({
     required String RFID,
     required DateTime birthday ,
     required int sex,
     required int age,
     required int weight,
     @Default('') String nickname,
     required int addition_method,
     @Default('') String RFIDm,
     @Default('') String RFIDf,
     @Default(0) int farm_id,
})=_LivestockModel;

   factory LivestockModel.fromJson(Map<String,dynamic>json)=>_$LivestockModelFromJson(json);
}