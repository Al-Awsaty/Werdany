class DietPlan {
  int id;
  int calories;
  int protein;
  int carbs;
  int fats;

  DietPlan({
    required this.id,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      id: json['id'],
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fats: json['fats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }
}
