import 'package:assets_mobile/utils/app_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    AppPrint.debugLog("SHARED PREFERENCES HELPER INITILIZE");
  }

  static Future<void> saveData(Map<String, dynamic> data) async {
    if (_preferences == null) {
      await init();
    }
    data.forEach((key, value) {
      if (value is String) {
        _preferences!.setString(key, value);
      } else if (value is int) {
        _preferences!.setInt(key, value);
      } else if (value is bool) {
        _preferences!.setBool(key, value);
      } else if (value is double) {
        _preferences!.setDouble(key, value);
      } else {
        throw Exception("Unsupported data type: $value");
      }
    });

    AppPrint.debugPrint("LOCAL STORAGE $data");
  }

  static Future<String> getString(String key) async {
    if (_preferences == null) {
      await init();
    }
    final value = _preferences!.getString(key) ?? "";
    return value;
  }

  static Future<bool> getBool(String key) async {
    if (_preferences == null) {
      await init();
    }
    final value = _preferences!.getBool(key) ?? false;
    return value;
  }

  static Future<void> clearData() async {
    await _preferences!.clear();
  }
}
