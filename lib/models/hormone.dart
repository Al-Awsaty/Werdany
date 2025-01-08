class Hormone {
  int id;
  String name;
  double dosage;
  String schedule;
  String purpose;

  Hormone({
    required this.id,
    required this.name,
    required this.dosage,
    required this.schedule,
    required this.purpose,
  });

  factory Hormone.fromJson(Map<String, dynamic> json) {
    return Hormone(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      schedule: json['schedule'],
      purpose: json['purpose'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'schedule': schedule,
      'purpose': purpose,
    };
  }
}
