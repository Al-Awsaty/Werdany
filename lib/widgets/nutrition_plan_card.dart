import 'package:flutter/material.dart';
import 'package:your_app/models/nutrition_plan.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class NutritionPlanCard extends StatelessWidget {
  final NutritionPlan nutritionPlan;
  final Function(NutritionPlan) onEdit;
  final Function(int) onDelete;
  final HormoneTrackerService hormoneTrackerService;

  NutritionPlanCard({
    required this.nutritionPlan,
    required this.onEdit,
    required this.onDelete,
    required this.hormoneTrackerService,
  });

  void _editNutritionPlan(BuildContext context) {
    final nameController = TextEditingController(text: nutritionPlan.name);
    final caloriesController = TextEditingController(text: nutritionPlan.calories.toString());
    final proteinController = TextEditingController(text: nutritionPlan.protein.toString());
    final carbsController = TextEditingController(text: nutritionPlan.carbs.toString());
    final fatsController = TextEditingController(text: nutritionPlan.fats.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Nutrition Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: caloriesController,
                decoration: InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: proteinController,
                decoration: InputDecoration(labelText: 'Protein (g)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: carbsController,
                decoration: InputDecoration(labelText: 'Carbs (g)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: fatsController,
                decoration: InputDecoration(labelText: 'Fats (g)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onEdit(
                  NutritionPlan(
                    id: nutritionPlan.id,
                    name: nameController.text,
                    calories: int.parse(caloriesController.text),
                    protein: int.parse(proteinController.text),
                    carbs: int.parse(carbsController.text),
                    fats: int.parse(fatsController.text),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutrition Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Name: ${nutritionPlan.name}'),
            SizedBox(height: 8),
            Text('Calories: ${nutritionPlan.calories}'),
            SizedBox(height: 8),
            Text('Protein: ${nutritionPlan.protein}g'),
            SizedBox(height: 8),
            Text('Carbs: ${nutritionPlan.carbs}g'),
            SizedBox(height: 8),
            Text('Fats: ${nutritionPlan.fats}g'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editNutritionPlan(context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(nutritionPlan.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
