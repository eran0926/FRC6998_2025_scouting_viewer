import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteUrlProvider extends ChangeNotifier {
  String _remoteUrl = 'http://localhost:8000';

  String get remoteUrl => _remoteUrl;

  Future<void> _loadRemoteUrl() async {
    // Load remote URL from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _remoteUrl = prefs.getString('remoteUrl') ?? 'http://localhost:8000';
    notifyListeners();
  }

  RemoteUrlProvider() {
    _loadRemoteUrl();
  }

  Future<void> setRemoteUrl(String url) async {
    _remoteUrl = url;
    notifyListeners();

    // 儲存到 SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remoteUrl', url);
  }
}
