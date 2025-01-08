class BodyStats {
  double weight;
  double muscleMass;
  double fatPercentage;

  BodyStats({required this.weight, required this.muscleMass, required this.fatPercentage});

  factory BodyStats.fromJson(Map<String, dynamic> json) {
    return BodyStats(
      weight: json['weight'],
      muscleMass: json['muscleMass'],
      fatPercentage: json['fatPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'muscleMass': muscleMass,
      'fatPercentage': fatPercentage,
    };
  }
}
