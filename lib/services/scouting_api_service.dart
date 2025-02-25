import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:viewer/utils/logger.dart';

class ScoutingApiService {
  final String _baseUrl = 'http://localhost:8000';

  Future<List<String>> fetchTeams() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/team_list'));
      logger.i('Response code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        logger.i('Teams: $data');
        return data.map((e) => e.toString()).toList();
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (e) {
      // print('Error: $e');
      logger.e('Error: $e');
      return [];
    }
  }
}
