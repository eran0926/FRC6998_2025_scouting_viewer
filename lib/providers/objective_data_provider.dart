import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewer/providers/remote_url_provider.dart';

import '../services/scouting_api_service.dart';

enum ObjectiveDataProviderState {
  fetching,
  teamUnset,
  teamNotFound,
  error,
  success
}

class ObjectiveDataProvider with ChangeNotifier {
  final BuildContext context;
  ObjectiveDataProviderState _state = ObjectiveDataProviderState.teamUnset;
  ObjectiveDataProviderState get state => _state;

  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  int _statusCode = 0;
  int get statusCode => _statusCode;

  late final ScoutingApiService _apiService;

  ObjectiveDataProvider(this.context) {
    _apiService = ScoutingApiService(Provider.of<RemoteUrlProvider>(context));
  }

  Future<void> selectTeam(String teamNumber) async {
    if (teamNumber.isEmpty) {
      _state = ObjectiveDataProviderState.teamUnset;
      notifyListeners();
      return;
    }
    _state = ObjectiveDataProviderState.fetching;
    notifyListeners();
    final (response, statusCode) =
        await _apiService.fetchObjectiveData(teamNumber);
    _statusCode = statusCode;
    if (statusCode == 200) {
      _data = jsonDecode(response);
      _state = ObjectiveDataProviderState.success;
    } else if (statusCode == 404) {
      _state = ObjectiveDataProviderState.teamNotFound;
    } else {
      _state = ObjectiveDataProviderState.error;
    }
    notifyListeners();
  }
}
