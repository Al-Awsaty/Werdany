import 'package:your_app/services/ai_recommendation_service.dart';
import 'package:your_app/services/rule_based_recommendation_service.dart';

class HybridRecommendationService {
  static final HybridRecommendationService _instance = HybridRecommendationService._internal();
  factory HybridRecommendationService() => _instance;
  HybridRecommendationService._internal();

  final AIRecommendationService _aiService = AIRecommendationService();
  final RuleBasedRecommendationService _ruleBasedService = RuleBasedRecommendationService();

  Future<Map<String, dynamic>> fetchRecommendations(Map<String, dynamic> userData) async {
    try {
      // Use rule-based system for common scenarios
      final ruleBasedRecommendation = _ruleBasedService.fetchRecommendations(userData);
      return ruleBasedRecommendation;
    } catch (e) {
      // Use AI model for personalized recommendations
      final aiRecommendation = await _aiService.fetchRecommendations(userData);
      return aiRecommendation;
    }
  }
}
