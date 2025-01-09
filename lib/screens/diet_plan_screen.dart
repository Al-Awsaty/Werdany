import 'package:flutter/material.dart';
import 'package:your_app/services/diet_plan_service.dart';
import 'package:your_app/models/diet_plan.dart';
import 'package:your_app/widgets/diet_card.dart';

class DietPlanScreen extends StatefulWidget {
  @override
  _DietPlanScreenState createState() => _DietPlanScreenState();
}

class _DietPlanScreenState extends State<DietPlanScreen> {
  List<DietPlan> _dietPlans = [];
  final DietPlanService _dietPlanService = DietPlanService();

  @override
  void initState() {
    super.initState();
    _loadDietPlans();
  }

  Future<void> _loadDietPlans() async {
    final plans = await _dietPlanService.getDietPlans();
    setState(() {
      _dietPlans = plans;
    });
  }

  void _addDietPlan(DietPlan plan) async {
    await _dietPlanService.addDietPlan(plan);
    _loadDietPlans();
  }

  void _editDietPlan(DietPlan plan) async {
    await _dietPlanService.updateDietPlan(plan);
    _loadDietPlans();
  }

  void _deleteDietPlan(int id) async {
    await _dietPlanService.deleteDietPlan(id);
    _loadDietPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Plans'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _dietPlans.length,
              itemBuilder: (context, index) {
                return DietCard(
                  dietPlan: _dietPlans[index],
                  onEdit: _editDietPlan,
                  onDelete: _deleteDietPlan,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add logic to add, edit, and delete diet plans
            },
            child: Text('Manage Diet Plans'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Body Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Diet Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Hormone Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Progress Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Trainer Dashboard',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Add navigation logic here
        },
      ),
    );
  }
}
