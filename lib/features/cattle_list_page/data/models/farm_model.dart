import 'package:flutter/material.dart';

class Livestock {
  final String RFID;
  final DateTime birthday;
  final int type;
  final String breed;
  final int sex;
  final int age;
  final int weight;
  final int addition_method;
  final String nickname;
  final String RFIDm;
  final String RFIDf;
  final int farm_id;

  Livestock(this.nickname, this.RFIDm, this.RFIDf, this.farm_id,
      {required this.RFID,
      required this.birthday,
      required this.type,
      required this.breed,
      required this.sex,
      required this.age,
      required this.weight,
      required this.addition_method});
}
