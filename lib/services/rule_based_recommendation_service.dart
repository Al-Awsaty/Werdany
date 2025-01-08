class RuleBasedRecommendationService {
  static final RuleBasedRecommendationService _instance = RuleBasedRecommendationService._internal();
  factory RuleBasedRecommendationService() => _instance;
  RuleBasedRecommendationService._internal();

  List<Map<String, dynamic>> _rules = [
    {
      'condition': (Map<String, dynamic> userData) => userData['goal'] == 'muscle_gain',
      'recommendation': {
        'hormone': 'Testosterone',
        'dosage': 200,
        'schedule': 'Weekly',
        'purpose': 'Increase muscle mass'
      }
    },
    {
      'condition': (Map<String, dynamic> userData) => userData['goal'] == 'weight_loss',
      'recommendation': {
        'hormone': 'Clenbuterol',
        'dosage': 40,
        'schedule': 'Daily',
        'purpose': 'Promote fat loss'
      }
    },
    {
      'condition': (Map<String, dynamic> userData) => userData['goal'] == 'maintenance',
      'recommendation': {
        'hormone': 'HGH',
        'dosage': 2,
        'schedule': 'Daily',
        'purpose': 'Maintain overall health'
      }
    },
  ];

  Map<String, dynamic> fetchRecommendations(Map<String, dynamic> userData) {
    for (var rule in _rules) {
      if (rule['condition'](userData)) {
        return rule['recommendation'];
      }
    }
    throw Exception('No matching recommendation found');
  }
}
