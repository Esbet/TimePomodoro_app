import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepomodoro_app/features/time/data/datasources/local_datasource.dart';
import 'package:timepomodoro_app/features/time/data/models/user_model.dart';

class LocalDatasourceImpl extends LocalDatasource {
  static const _keyPrefix = 'pomodoro_';
  static const _keyBreaks = 'breaks_';
  static const String _keyName = 'name';
  static const String _keyEmail = 'email';

  @override
  Future<int> getTotalMinutesForDate(String date) async {
    final prefs = await SharedPreferences.getInstance();
    int totalMinutes = 0;

    Set<String> keys = prefs.getKeys();

    for (String key in keys) {
      if (key.startsWith('$_keyPrefix$date')) {
        int minutes = prefs.getInt(key) ?? 0;
        totalMinutes += minutes;
      }
    }

    return totalMinutes;
  }

  @override
  Future<bool> saveTotalMinutesForDate(String date, int minutes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int existingMinutes = prefs.getInt('$_keyPrefix$date') ?? 0;
      int totalMinutes = existingMinutes + minutes;
      await prefs.setInt('$_keyPrefix$date', totalMinutes);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getTotalPomodoros() async {
    final prefs = await SharedPreferences.getInstance();
    int totalMinutes = 0;

    Set<String> keys = prefs.getKeys();

    for (String key in keys) {
      if (key.startsWith(_keyPrefix)) {
        int minutes = prefs.getInt(key) ?? 0;
        totalMinutes += minutes;
      }
    }

    return totalMinutes;
  }

  @override
  Future<bool> saveTotalBreaksForDate(String date, int minutes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int existingCount = prefs.getInt('$_keyBreaks$date') ?? 0;
      int totalCount = existingCount + 1;
      await prefs.setInt('$_keyBreaks$date', totalCount);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getTotalBreaks() async {
    final prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    int totalBreaks = 0;
    for (String key in keys) {
      if (key.startsWith(_keyBreaks)) {
        int minutes = prefs.getInt(key) ?? 0;
        totalBreaks = minutes;
      }
    }
    return totalBreaks;
  }

  @override
  Future<bool> saveUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.setString(_keyName, name);
      await prefs.setString(_keyEmail, email);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);

    return UserModel.fromMap({'name': name, 'email': email});
  }

  @override
  Future<bool> hasUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);

    return name != null && email != null;
  }
}
