import 'package:flutter/material.dart';
import 'package:your_app/models/diet_plan.dart';

class DietCard extends StatelessWidget {
  final DietPlan dietPlan;
  final Function(DietPlan) onEdit;
  final Function(int) onDelete;

  DietCard({
    required this.dietPlan,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diet Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Calories: ${dietPlan.calories}'),
            SizedBox(height: 8),
            Text('Protein: ${dietPlan.protein}g'),
            SizedBox(height: 8),
            Text('Carbs: ${dietPlan.carbs}g'),
            SizedBox(height: 8),
            Text('Fats: ${dietPlan.fats}g'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(dietPlan),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(dietPlan.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
