import 'package:http/http.dart' as http;
import 'dart:convert';

class AIRecommendationService {
  static final AIRecommendationService _instance = AIRecommendationService._internal();
  factory AIRecommendationService() => _instance;
  AIRecommendationService._internal();

  Future<Map<String, dynamic>> fetchRecommendations(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('https://api.example.com/ai-recommendations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_TOKEN',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch AI recommendations');
    }
  }
}
