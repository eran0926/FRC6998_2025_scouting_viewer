import 'package:flutter/material.dart';
import '../services/scouting_api_service.dart';

enum ObjectiveDataProviderState { fetching, teamUnset, teamNotFound, success }

class ObjectiveDataProvider with ChangeNotifier {
  ObjectiveDataProviderState _state = ObjectiveDataProviderState.teamUnset;
  ObjectiveDataProviderState get state => _state;
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  final ScoutingApiService _apiService = ScoutingApiService();

  Future<void> selectTeam(String teamNumber) async {
    if (teamNumber.isEmpty) {
      _state = ObjectiveDataProviderState.teamUnset;
      notifyListeners();
      return;
    }
    _state = ObjectiveDataProviderState.fetching;
    notifyListeners();
    _data = await _apiService.fetchObjectiveData(teamNumber);
    if (_data.isEmpty) {
      _state = ObjectiveDataProviderState.teamNotFound;
    } else {
      _state = ObjectiveDataProviderState.success;
    }
    notifyListeners();
  }
}
