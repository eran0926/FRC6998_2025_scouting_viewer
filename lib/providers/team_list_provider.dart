import 'package:flutter/material.dart';
import 'package:viewer/services/scouting_api_service.dart';

class TeamListProvider extends ChangeNotifier {
  List<dynamic> _teams = [];
  bool _isLoading = false;
  DateTime _lastUpdated = DateTime.now();

  List<dynamic> get teams {
    if (_isLoading) {
      return [];
    }
    if (_teams.isEmpty ||
        _lastUpdated.isBefore(DateTime.now().subtract(Duration(minutes: 5)))) {
      fetchTeams();
    }
    return _teams;
  }

  Future<void> fetchTeams() async {
    _isLoading = true;
    notifyListeners();

    final apiService = ScoutingApiService();
    _teams = await apiService.fetchTeams();

    _isLoading = false;
    notifyListeners();
  }
}
