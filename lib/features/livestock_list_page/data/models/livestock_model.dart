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
     required String nickname,
     required int addition_method,
     required String RFIDm,
     required String RFIDf,
     required int farm_id,
})=_LivestockModel;

   factory LivestockModel.fromJson(Map<String,dynamic>json)=>_$LivestockModelFromJson(json);
}