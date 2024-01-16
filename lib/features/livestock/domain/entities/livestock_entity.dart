import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'livestock', primaryKeys: ['id'])
class LivestockEntity extends Equatable {
  // DateTime
  final String? createdAt;
  final int? id;
  final String? rfid;
  final String? nickname;

  // DateTime
  final String? birthday;

  // LocalizedSting
  final int? type;
  final int? breed;
  final int? sex;
  final int? age;
  final double? weight;
  final int? additionMethod;
  final String? motherRfid;
  final String? fatherRfid;
  final int? farmId;
  final String photo;

  // LocalizedSting
  final String? status;

  const LivestockEntity({
    required this.createdAt,
    required this.id,
    required this.rfid,
    required this.nickname,
    required this.birthday,
    required this.type,
    required this.breed,
    required this.sex,
    required this.age,
    required this.weight,
    required this.additionMethod,
    required this.motherRfid,
    required this.fatherRfid,
    required this.farmId,
    required this.photo,
    required this.status,
  });

  @override
  List<Object?> get props => [
        createdAt,
        id,
        rfid,
        nickname,
        birthday,
        type,
        breed,
        sex,
        age,
        weight,
        additionMethod,
        motherRfid,
        fatherRfid,
        farmId,
        photo,
        status,
      ];
}
