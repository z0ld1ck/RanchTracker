class CattleProfile {
  String RFD;
  String name;
  String weight;
  String RFIDm;
  String RFIDf;

  CattleProfile({
    required this.name,
    required this.RFD,
    required this.weight,
    required this.RFIDm,
    required this.RFIDf,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'RFD': RFD,
      'weight': weight,
      'RFIDm': RFIDm,
      'RFIDf': RFIDf,
    };
  }
}
