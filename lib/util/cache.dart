import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static final Cache _singleton = Cache._internal();

  factory Cache() {
    return _singleton;
  }

  Cache._internal();

  Future<void> cacheData(String key, String data, int expiredSecond) async {
    final DateTime expiredTime = DateTime.now().add(Duration(seconds: expiredSecond));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, data);
    await prefs.setString("${key}ExpiredTime", expiredTime.toIso8601String());
  }

  Future<String?> checkCache(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(key);
    final String? expiredDate = prefs.getString("${key}ExpiredTime");

    if (cachedData != null && expiredDate != null) {
      final DateTime currentTime = DateTime.now();
      final DateTime expiredTime = DateTime.parse(expiredDate);
      print(currentTime.difference(expiredTime).inSeconds);
      if (currentTime.difference(expiredTime).inSeconds < 0) {
        return cachedData;
      } else {
        // Cache expired
        prefs.remove(key);
        prefs.remove("${key}ExpiredTime");
      }
    }
    return null;
  }
}
