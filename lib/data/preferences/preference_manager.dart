import 'dart:async';

import 'package:moneytree/data/preferences/preference_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  //Singleton instance
  PreferenceManager._internal();

  static PreferenceManager instance = new PreferenceManager._internal();
  static SharedPreferences _prefs;

  factory PreferenceManager() {
    return instance;
  }

  Future<void> clearAll() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    for (String key in _prefs.getKeys()) {
      if (key == PreferenceConstants.IS_LOGIN ||
          key == PreferenceConstants.PROFILE_IMAGE_PATH ||
          key == PreferenceConstants.API_TOKEN) {
        _prefs.remove(key);
      }
    }
    // _prefs.clear();
  }

  /// ------------------( IS LOGIN )------------------
  Future<bool> getIsLogin() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();

    return _prefs.getBool(PreferenceConstants.IS_LOGIN);
  }

  Future<void> setIsLogin(bool isLogin) async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(PreferenceConstants.IS_LOGIN, isLogin);
  }

  /// ------------------( SET PROFILE PATH )------------------
  Future<String> getProfileImagePath() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();

    return _prefs.getString(PreferenceConstants.PROFILE_IMAGE_PATH);
  }

  Future<void> setProfileImagePath(String proPic) async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.PROFILE_IMAGE_PATH, proPic);
  }

  // ///API Token
  Future<void> setAPIToken(String token) async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.API_TOKEN, token);
  }

  Future<String> getAPIToken() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    final token = _prefs.get(PreferenceConstants.API_TOKEN) ?? "";
    return token;
  }

  Future<void> setTask({String task, String id}) async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _prefs.setString(id, task);
  }

  Future<String> getTask({String id}) async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    final token = _prefs.get(id) ?? "";
    return token;
  }
}
