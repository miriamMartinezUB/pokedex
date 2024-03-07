import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Int methods
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// String methods
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  /// StringList methods

  StreamController<bool> stringListNeedRefresh = StreamController<bool>.broadcast();

  Future<void> saveStringList(String key, List<String>? value) async {
    await _prefs.setStringList(key, value ?? []);
    stringListNeedRefresh.add(true);
  }

  Future<void> addValueToStringList(String key, String value) async {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (!list.contains(value)) {
      list.add(value);
      await _prefs.setStringList(key, list);
      stringListNeedRefresh.add(true);
    }
  }

  Future<void> removeValueToStringList(String key, String value) async {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (list.contains(value)) {
      list.remove(value);
      await _prefs.setStringList(key, list);
      stringListNeedRefresh.add(true);
    }
  }

  List<String> getStringList(String key) {
    if (_prefs.getKeys().contains(key)) {
      return _prefs.getStringList(key) ?? <String>[];
    }
    return [];
  }

  bool stringListContainValue(String key, String value) {
    List<String> list = _prefs.getStringList(key) ?? [];
    return list.contains(value);
  }
}
