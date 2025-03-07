import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewer/providers/remote_url_provider.dart';
import 'package:viewer/services/scouting_api_service.dart';

class TeamListProvider extends ChangeNotifier {
  final BuildContext context;
  List<dynamic> _teams = [];
  bool _isLoading = false;
  DateTime _lastUpdated = DateTime.now();

  TeamListProvider(this.context);

  List<dynamic> get teams {
    if (_isLoading) {
      return [];
    }
    if (_teams.isEmpty ||
        _lastUpdated.isBefore(DateTime.now().subtract(Duration(minutes: 5)))) {
      _lastUpdated = DateTime.now();
      fetchTeams();
    }
    return _teams;
  }

  Future<void> fetchTeams() async {
    _isLoading = true;
    notifyListeners();

    final apiService =
        ScoutingApiService(Provider.of<RemoteUrlProvider>(context));
    _teams = await apiService.fetchTeams();

    _isLoading = false;
    notifyListeners();
  }
}
