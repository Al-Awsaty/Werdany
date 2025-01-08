import 'package:flutter/material.dart';
import 'package:your_app/services/nutrition_plan_service.dart';
import 'package:your_app/models/nutrition_plan.dart';
import 'package:your_app/widgets/nutrition_plan_card.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class NutritionPlanScreen extends StatefulWidget {
  @override
  _NutritionPlanScreenState createState() => _NutritionPlanScreenState();
}

class _NutritionPlanScreenState extends State<NutritionPlanScreen> {
  List<NutritionPlan> _nutritionPlans = [];
  final NutritionPlanService _nutritionPlanService = NutritionPlanService();
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();

  @override
  void initState() {
    super.initState();
    _loadNutritionPlans();
  }

  Future<void> _loadNutritionPlans() async {
    final plans = await _nutritionPlanService.getNutritionPlans();
    setState(() {
      _nutritionPlans = plans;
    });
  }

  void _addNutritionPlan(NutritionPlan plan) async {
    await _nutritionPlanService.addNutritionPlan(plan);
    _loadNutritionPlans();
  }

  void _editNutritionPlan(NutritionPlan plan) async {
    await _nutritionPlanService.updateNutritionPlan(plan);
    _loadNutritionPlans();
  }

  void _deleteNutritionPlan(int id) async {
    await _nutritionPlanService.deleteNutritionPlan(id);
    _loadNutritionPlans();
  }

  void _showAddNutritionPlanDialog() {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();
    final carbsController = TextEditingController();
    final fatsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Nutrition Plan'),
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
                _addNutritionPlan(
                  NutritionPlan(
                    id: 0,
                    name: nameController.text,
                    calories: int.parse(caloriesController.text),
                    protein: int.parse(proteinController.text),
                    carbs: int.parse(carbsController.text),
                    fats: int.parse(fatsController.text),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNutritionPlanDialog(NutritionPlan plan) {
    final nameController = TextEditingController(text: plan.name);
    final caloriesController = TextEditingController(text: plan.calories.toString());
    final proteinController = TextEditingController(text: plan.protein.toString());
    final carbsController = TextEditingController(text: plan.carbs.toString());
    final fatsController = TextEditingController(text: plan.fats.toString());

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
                _editNutritionPlan(
                  NutritionPlan(
                    id: plan.id,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Plans'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _nutritionPlans.length,
              itemBuilder: (context, index) {
                return NutritionPlanCard(
                  nutritionPlan: _nutritionPlans[index],
                  onEdit: _editNutritionPlan,
                  onDelete: _deleteNutritionPlan,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showAddNutritionPlanDialog,
            child: Text('Manage Nutrition Plans'),
          ),
        ],
      ),
    );
  }
}
