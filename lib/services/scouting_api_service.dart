import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:viewer/utils/logger.dart';

class ScoutingApiService {
  final Uri _baseUrl = Uri.parse('http://localhost:8000');

  Future<List<String>> fetchTeams() async {
    try {
      final response = await http.get(_baseUrl.replace(path: '/team_list'));
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

  Future<Map<String, dynamic>> fetchObjectiveData(String teamNumber) async {
    try {
      final response = await http.get(_baseUrl.replace(
          path: '/objective/result',
          queryParameters: {'team_number': teamNumber}));
      logger.i('Response code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        logger.i('Objective data: $data');
        return data;
      }
      if (response.statusCode == 404) {
        return {};
      } else {
        throw Exception('Failed to load objective data');
      }
    } catch (e) {
      // print('Error: $e');
      logger.e('Error: $e');
      return {};
    }
  }
}
