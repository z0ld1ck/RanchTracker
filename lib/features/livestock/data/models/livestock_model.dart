import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:malshy/features/livestock/data/models/addition_type_model.dart';

part 'livestock_model.freezed.dart';
part 'livestock_model.g.dart';

@freezed
class LivestockModel with _$LivestockModel{
   factory LivestockModel({
     required String rfid,
     required DateTime birthday ,
     required int sex,
     required int age,
     required int weight,
     @Default('') String nickname,
     required AdditionTypeModel addition_method,
     @Default('') String mother_rfid,
     @Default('') String father_rfid,
})=_LivestockModel;

   factory LivestockModel.fromJson(Map<String,dynamic>json)=>_$LivestockModelFromJson(json);
}