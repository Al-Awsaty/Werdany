class BodyStats {
  double weight;
  double muscleMass;
  double fatPercentage;
  DateTime date;

  BodyStats({required this.weight, required this.muscleMass, required this.fatPercentage, required this.date});

  factory BodyStats.fromJson(Map<String, dynamic> json) {
    return BodyStats(
      weight: json['weight'],
      muscleMass: json['muscleMass'],
      fatPercentage: json['fatPercentage'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'muscleMass': muscleMass,
      'fatPercentage': fatPercentage,
      'date': date.toIso8601String(),
    };
  }
}
