import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:viewer/providers/remote_url_provider.dart';

import 'package:viewer/utils/logger.dart';

class ScoutingApiService {
  final BuildContext context;

  ScoutingApiService(this.context);

  Uri get _baseUrl =>
      Uri.parse(Provider.of<RemoteUrlProvider>(context).remoteUrl);

  Future<List<String>> fetchTeams() async {
    try {
      final response = await http.get(_baseUrl.replace(path: '/team_list'));
      logger.i('Response code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        logger.i('Teams: $data');
        List<String> teamList = data.map((e) => e.toString()).toList();
        teamList.sort();
        return teamList;
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (e) {
      // print('Error: $e');
      logger.e('Error: $e');
      return [];
    }
  }

  Future<(String, int)> fetchObjectiveData(String teamNumber) async {
    try {
      final response = await http.get(_baseUrl.replace(
          path: '/objective/result',
          queryParameters: {'team_number': teamNumber}));
      return (response.body, response.statusCode);
    } on http.ClientException catch (e) {
      logger.e(e);
      return ('', 600);
    } catch (e) {
      logger.e('Error: $e');
      return ('', 700);
    }
  }
}
