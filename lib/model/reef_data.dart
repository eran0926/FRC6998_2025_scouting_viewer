enum ReefDataType { sum, average }

class ReefData {
  final ReefLevelData l1, l2, l3, l4, caculated;
  final ReefDataType type;

  ReefData({
    required this.l1,
    required this.l2,
    required this.l3,
    required this.l4,
    required this.caculated,
    required this.type,
  });

  factory ReefData.fromJson(Map<String, dynamic> json) {
    ReefDataType type =
        ReefDataType.values.firstWhere((e) => e.name == json['type']);
    return ReefData(
      l1: ReefLevelData.fromJson(json['l1'], type),
      l2: ReefLevelData.fromJson(json['l2'], type),
      l3: ReefLevelData.fromJson(json['l3'], type),
      l4: ReefLevelData.fromJson(json['l4'], type),
      caculated: ReefLevelData.fromJson(json[type.name], type),
      type: type,
    );
  }

  Map<String, List<String>> toTableData() {
    return {
      'l4': l4.toList(),
      'l3': l3.toList(),
      'l2': l2.toList(),
      'l1': l1.toList(),
      'all_level': caculated.toList(),
    };
  }
}

class ReefLevelData {
  final double ab, cd, ef, gh, ij, kl, caculated;
  ReefDataType type;

  ReefLevelData({
    required this.ab,
    required this.cd,
    required this.ef,
    required this.gh,
    required this.ij,
    required this.kl,
    required this.caculated,
    required this.type,
  });

  factory ReefLevelData.fromJson(Map<String, dynamic> json, ReefDataType type) {
    return ReefLevelData(
      ab: json['AB'],
      cd: json['CD'],
      ef: json['EF'],
      gh: json['GH'],
      ij: json['IJ'],
      kl: json['KL'],
      caculated: json[type.name],
      type: type,
    );
  }

  List<String> toList() {
    return [
      ab.toString(),
      cd.toString(),
      ef.toString(),
      gh.toString(),
      ij.toString(),
      kl.toString(),
      caculated.toString()
    ];
  }
}
